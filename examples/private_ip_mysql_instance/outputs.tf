output "self_link" {
	value = module.private_mysql_instance.self_link
}

output "connection_name" {
	value = module.private_mysql_instance.connection_name
}

output "private_ip_address" {
	value = module.private_mysql_instance.private_ip_address
}

output "name" {
	value = module.private_mysql_instance.name
} 
