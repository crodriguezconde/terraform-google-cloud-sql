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

# ==== VPC network definition ==== #

module "vpc_network" {
  source           = "git::https://github.com/crodriguezconde/vpc_network.git"
  vpc_network_name = "private-csql-vpc"
  vpc_description  = "VPC network created to house the CSQL instance private IP."
  routing_mode     = "GLOBAL"
}

# ==== Allocated IP range definition ==== #

module "allocated_ip_address_range" {
  source                    = "git::https://github.com/crodriguezconde/allocated_ip_address_range.git"
  name                      = "private-ip-allocation"
  description               = "Allocation for the Cloud SQL instance."
  prefix_length             = 16
  address_type              = "INTERNAL"
  purpose                   = "VPC_PEERING"
  associated_vpc_network_id = module.vpc_network.vpc_network_id

}

module "private_connection" {
  source                      = "git::https://github.com/crodriguezconde/private_connection.git"
  associated_vpc_network_id   = module.vpc_network.vpc_network_id
  allocated_ip_address_ranges = module.allocated_ip_address_range.name
}

module "private_mysql_instance" {

  # This is needed as we need to first peer with the service producer before assigning a private IP address with Cloud SQL.
  depends_on = [module.private_connection]

  source = "git::https://github.com/crodriguezconde/cloud_sql.git//modules/cloud_sql_mysql"

  name             = var.instance_name
  database_version = var.mysql_version
  cloud_sql_region = var.instance_region
  # We are disabling the Public IP from the Cloud SQL instance as
  # we only want to access it through private IP address.
  ipv4_enabled   = false
  vpc_network_id = module.vpc_network.vpc_network_id


}

# Second-generation instances include a default 'root'@'%' user with no password. 
#This user will be deleted by Terraform on instance creation. 
# Therefore, we will create a google_sql_user to define a custom user with a restricted host and strong password.

module "cloud_sql_user" {
  source = "git::https://github.com/crodriguezconde/cloud_sql.git//modules/cloud_sql_user"

  sql_user_name           = var.sql_user_name
  cloud_sql_instance_name = module.private_mysql_instance.name
  sql_user_password       = var.sql_user_password
}
