
output "self_link" {
	value = module.private_postgres_instance.self_link
}

output "connection_name" {
	value = module.private_postgres_instance.connection_name
}

output "private_ip_address" {
	value = module.private_postgres_instance.private_ip_address
}

output "name" {
	value = module.private_postgres_instance.name
} 

### Outputs for Cloud SQL PostgreSQL read replica

output "read_replica_self_link" {
	value = module.postgres_read_replica.self_link
}

output "read_replica_connection_name" {
	value = module.postgres_read_replica.connection_name
}

output "read_replica_private_ip_address" {
	value = module.postgres_read_replica.private_ip_address
}

output "read_replica_name" {
	value = module.postgres_read_replica.name
}
