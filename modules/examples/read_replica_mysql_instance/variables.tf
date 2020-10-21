variable "project_id" {}

### Variables declaration for Cloud SQL instance (master)
variable "mysql_version" {}
variable "instance_name" {}
variable "sql_region" {}

### Variable declaration for Cloud SQL replica instance

variable "number_of_replicas" {}



### Variable declaration for Cloud SQL user

variable "sql_user_name" {}
variable "sql_user_password" {}
