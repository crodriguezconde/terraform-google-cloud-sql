### Variables definition for VPC network
vpc_network_name = "private-csql-vpc"
routing_mode     = "GLOBAL"

### Variables definition for IP address allocation range
allocated_ip_address_range_name = "private-ip-allocation"
prefix_length                   = 16

### Variables definition for Cloud SQL instance
instance_name = "private-mysql-instance"
sql_region    = "europe-west1"
mysql_version = "MYSQL_5_7"


## Variables definition for Cloud SQL user
sql_user_name = "terraform-cloud-sql-mysql-user"


