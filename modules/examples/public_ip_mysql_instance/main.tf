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

module "public_mysql_instance" {

  source = "git::https://github.com/crodriguezconde/cloud_sql.git//modules/cloud_sql_mysql"

  name             = var.instance_name
  database_version = var.mysql_version
  cloud_sql_region = var.instance_region
}

# Second-generation instances include a default 'root'@'%' user with no password. 
#This user will be deleted by Terraform on instance creation. 
# Therefore, we will create a google_sql_user to define a custom user with a restricted host and strong password.

module "cloud_sql_user" {
  source = "git::https://github.com/crodriguezconde/cloud_sql.git//modules/cloud_sql_user?"

  sql_user_name           = var.sql_user_name
  cloud_sql_instance_name = module.public_mysql_instance.name
  sql_user_password       = var.sql_user_password
}
