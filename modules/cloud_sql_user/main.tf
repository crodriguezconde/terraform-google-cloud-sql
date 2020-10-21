#provider "google" { project = var.project_id}

resource "google_sql_user" "new_csql_user" {
  name     = var.sql_user_name
  instance = var.cloud_sql_instance_name
  password = var.sql_user_password
}

