terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    	version = "<= 3.43"
		}
  }
}

provider "google" {
  project = var.project_id
}

module "public_postgres_instance" {

  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_postgres?ref=v0.0.2"

  name             = var.instance_name
  database_version = var.postgres_version
  cloud_sql_region = var.sql_region
}

# Second-generation instances include a default 'root'@'%' user with no password. 
#This user will be deleted by Terraform on instance creation. 
# Therefore, we will create a google_sql_user to define a custom user with a restricted host and strong password.

module "cloud_sql_user" {
  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_user?ref=v0.0.2"

  sql_user_name           = var.sql_user_name
  cloud_sql_instance_name = module.public_postgres_instance.name
  # Postgres will error out if you leave the password empty.
  # Also, please remember to not hardcode your password into the main.tf file as it could be pushed to version control. 
  sql_user_password = var.sql_user_password
}
