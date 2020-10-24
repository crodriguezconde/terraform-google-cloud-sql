### Output declaration for Cloud SQL master instance

output "self_link" {
  value = module.master_mysql_instance.self_link
}

output "connection_name" {
  value = module.master_mysql_instance.connection_name
}

output "public_ip_address" {
  value = module.master_mysql_instance.public_ip_address
}

output "name" {
  value = module.master_mysql_instance.name
}

### Output declaration for Cloud SQL read replica instanc

output "read_replica_instance_self_link" {
  value = module.mysql_read_replica_instance[*].self_link
}

output "read_replica_instance_connection_name" {
  value = module.mysql_read_replica_instance[*].connection_name
}

output "read_replica_instance_public_ip_address" {
  value = module.mysql_read_replica_instance[*].public_ip_address
}

output "read_replica_instance_name" {
  value = module.mysql_read_replica_instance[*].name
}

