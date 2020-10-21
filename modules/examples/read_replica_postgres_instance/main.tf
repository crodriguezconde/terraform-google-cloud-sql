terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.project_id
}

locals {
  postgres_version = "POSTGRES_10"
  csql_region      = "europe-west1"

}

# ==== VPC network definition ==== #

module "vpc_network" {
  source           = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/vpc_network"
  vpc_network_name = var.vpc_network_name
  vpc_description  = "VPC network created to house the CSQL instance private IP."
  routing_mode     = var.routing_mode
}

# ==== Allocated IP range definition ==== #

module "allocated_ip_address_range" {
  source                    = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/allocated_ip_address_range"
  name                      = var.allocated_ip_address_range_name
  description               = "Allocation for the Cloud SQL instance."
  prefix_length             = var.prefix_length
  address_type              = "INTERNAL"
  purpose                   = "VPC_PEERING"
  associated_vpc_network_id = module.vpc_network.vpc_network_id

}

module "private_connection" {
  source                      = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/private_connection"
  associated_vpc_network_id   = module.vpc_network.vpc_network_id
  allocated_ip_address_ranges = [module.allocated_ip_address_range.name]
}


module "private_postgres_instance" {

  # This is needed as we need to first peer with the service producer before assigning a private IP address with Cloud SQL.
  depends_on = [module.private_connection]

  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_postgres"

  name             = var.instance_name
  database_version = var.postgres_version
  cloud_sql_region = var.sql_region
  # We are disabling the Public IP from the Cloud SQL instance as
  # we only want to access it through private IP address.
  ipv4_enabled   = false
  vpc_network_id = module.vpc_network.vpc_network_id

  #Both PITR and backups must be enabled in order to be able to create a replica afterwards.
  point_in_time_recovery_enabled = true
  backup_enabled                 = true

}

# Second-generation instances include a default 'root'@'%' user with no password. 
#This user will be deleted by Terraform on instance creation. 
# Therefore, we will create a google_sql_user to define a custom user with a restricted host and strong password.

module "cloud_sql_user" {
  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_user"

  sql_user_name           = var.sql_user_name
  cloud_sql_instance_name = module.private_postgres_instance.name
  # For PostgreSQL instances, we need to define a password in order to successfully create a new user.
  sql_user_password = var.sql_user_password
}

module "postgres_read_replica" {

  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_postgres"

  name                 = "${module.private_postgres_instance.name}-replica"
  database_version     = var.postgres_version
  cloud_sql_region     = var.sql_region
  master_instance_name = module.private_postgres_instance.name

}

