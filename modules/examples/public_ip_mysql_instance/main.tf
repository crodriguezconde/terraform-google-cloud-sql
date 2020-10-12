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


