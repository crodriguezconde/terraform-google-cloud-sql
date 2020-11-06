### Variables definition for VPC network
vpc_network_name = "private-csql-vpc-for-postgres"
routing_mode     = "GLOBAL"

### Variables definition for IP address allocation range
allocated_ip_address_range_name = "private-ip-allocation-for-postgres"
prefix_length                   = 16

### Variables definition for Cloud SQL instance
instance_name    = "private-postgres-instance"
sql_region       = "europe-west1"
postgres_version = "POSTGRES_10"

## Variables definition for Cloud SQL user
sql_user_name = "cloud-sql-postgres-user"
