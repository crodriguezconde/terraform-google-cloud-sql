#variable "project_id" {}

variable "sql_user_name" {
  type        = string
  description = "(Required) The name of the user."
}

variable "cloud_sql_instance_name" {
  type        = string
  description = "(Required) The name of the Cloud SQL instance the user will be created on."
}

variable "sql_user_password" {
  type        = string
  description = "(Required) The password for the user."
	validation {
		condition = var.sql_user_password != null && var.sql_user_password != ""
		error_message = "The Cloud SQL user password must not be empty."
	}
}
