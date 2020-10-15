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

module "public_postgres_instance" {

  source = "git::https://github.com/crodriguezconde/cloud_sql.git//modules/cloud_sql_postgres"

  name             = "Replace with the name of the Cloud SQL instance"
  database_version = "POSTGRES_10"
  cloud_sql_region = "europe-west1"
	vpc_network_id   = ""
}

# Second-generation instances include a default 'root'@'%' user with no password. 
#This user will be deleted by Terraform on instance creation. 
# Therefore, we will create a google_sql_user to define a custom user with a restricted host and strong password.

module "cloud_sql_user" {
  source = "git::https://github.com/crodriguezconde/cloud_sql.git//modules/cloud_sql_user"

  sql_user_name           = "${terraform.workspace}-terraform-postgres-user"
  cloud_sql_instance_name = module.public_postgres_instance.name
  # The password for the user should not be hardcoded in the configuration file, but just for the sake of the example, the password here is empty.
  sql_user_password = ""
}
