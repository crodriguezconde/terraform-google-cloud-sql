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

  mysql_version = "MYSQL_5_7"
  csql_region   = "europe-west1"

}


module "master_mysql_instance" {


  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_mysql"

  name             = "Replace with the name of the Cloud SQL instance"
  database_version = local.mysql_version
  cloud_sql_region = local.csql_region
  # When creating a replica, is necessary to enable binary logs as well as backup(s) within the master instance.
  binary_log_enabled = true
  backup_enabled     = true
}

# Second-generation instances include a default 'root'@'%' user with no password. 
#This user will be deleted by Terraform on instance creation. 
# Therefore, we will create a google_sql_user to define a custom user with a restricted host and strong password.

module "cloud_sql_user" {
  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_user"

  sql_user_name           = "${terraform.workspace}-terraform-user"
  cloud_sql_instance_name = module.master_mysql_instance.name
  # The password for the user should not be hardcoded in the configuration file, but just for the sake of the example, the password here is empty.
  sql_user_password = ""
}

module "mysql_read_replica_instance" {

  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_mysql"

  # This will create 2 different Cloud SQL MySQL read replica instances with the master instance name - count number
  count            = 2
  name             = "${module.master_mysql_instance.name}-replica-${count.index}"
  database_version = local.mysql_version
  cloud_sql_region = local.csql_region

  master_instance_name = module.master_mysql_instance.name


}


