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


module "master_mysql_instance" {


  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_mysql?ref=v0.0.2"

  name             = var.instance_name
  database_version = var.mysql_version
  cloud_sql_region = var.sql_region
  # When creating a replica, is necessary to enable binary logs as well as backup(s) within the master instance.
  binary_log_enabled = true
  backup_enabled     = true
}

# Second-generation instances include a default 'root'@'%' user with no password. 
#This user will be deleted by Terraform on instance creation. 
# Therefore, we will create a google_sql_user to define a custom user with a restricted host and strong password.

# Any users created for the Cloud SQL master instance will be inherited to the read replica(s) instance as well.
module "cloud_sql_user" {
  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_user?ref=v0.0.2"

  sql_user_name           = var.sql_user_name
  cloud_sql_instance_name = module.master_mysql_instance.name
  sql_user_password       = var.sql_user_password
}

module "mysql_read_replica_instance" {

  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_mysql?ref=v0.0.2"

  # This will create X different Cloud SQL MySQL read replica instances with the master instance name - count number
  count            = var.number_of_replicas
  name             = "${module.master_mysql_instance.name}-replica-${count.index}"
  database_version = var.mysql_version
  cloud_sql_region = var.sql_region

  master_instance_name = module.master_mysql_instance.name


}


