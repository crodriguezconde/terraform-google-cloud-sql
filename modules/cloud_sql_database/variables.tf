variable "database_name" {
	type = string
	description = "(Required) The name of the database in the Cloud SQL instance. This does not include the project ID or instance name."
	default = "tf-database"
}

variable "instance_name" {
	type = string
	description = "(Required) The name of the Cloud SQL instance. This does not include the project ID."
}


