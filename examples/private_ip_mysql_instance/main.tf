terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "<= 3.43"
    }
  }
}

provider "google" {
  project = var.project_id
}

# ==== VPC network definition ==== #

module "vpc_network" {
  source           = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/vpc_network?ref=v0.0.2"
  vpc_network_name = var.vpc_network_name
  vpc_description  = "VPC network created to house the CSQL instance private IP."
  routing_mode     = var.routing_mode
}

# ==== Allocated IP range definition ==== #

module "allocated_ip_address_range" {
  source                    = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/allocated_ip_address_range?ref=v0.0.2"
  name                      = var.allocated_ip_address_range_name
  description               = "Allocation for the Cloud SQL instance."
  prefix_length             = var.prefix_length
  address_type              = "INTERNAL"
  purpose                   = "VPC_PEERING"
  associated_vpc_network_id = module.vpc_network.vpc_network_id

}

module "private_connection" {
  source                      = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/private_connection?ref=v0.0.2"
  associated_vpc_network_id   = module.vpc_network.vpc_network_id
  allocated_ip_address_ranges = [module.allocated_ip_address_range.name]
}

module "private_mysql_instance" {

  # This is needed as we need to first peer with the service producer before assigning a private IP address with Cloud SQL.
  depends_on = [module.private_connection]

  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_mysql?ref=v0.0.2"

  name             = var.instance_name
  database_version = var.mysql_version
  cloud_sql_region = var.sql_region
  # We are disabling the Public IP from the Cloud SQL instance as
  # we only want to access it through private IP address.
  ipv4_enabled   = false
  vpc_network_id = module.vpc_network.vpc_network_id

}

# Second-generation instances include a default 'root'@'%' user with no password. 
#This user will be deleted by Terraform on instance creation. 
# Therefore, we will create a google_sql_user to define a custom user with a restricted host and strong password.

module "cloud_sql_user" {
  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_user?ref=v0.0.2"

  sql_user_name           = var.sql_user_name
  cloud_sql_instance_name = module.private_mysql_instance.name
  sql_user_password       = var.sql_user_password
}
