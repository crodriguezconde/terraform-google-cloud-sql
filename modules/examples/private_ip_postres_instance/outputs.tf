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
