variable "project_id" {}

### Variables declaration for VPC network
variable "vpc_network_name" {}
variable "routing_mode" {}

### Variables declaration for IP address allocation range
variable "allocated_ip_address_range_name" {}
variable "prefix_length" {}

### Variables declaration for Cloud SQL instance
variable "instance_name" {}
variable "sql_region" {}
variable "postgres_version" {}


## Variables declaration for Cloud SQL user
variable "sql_user_name" {}
variable "sql_user_password" {}
