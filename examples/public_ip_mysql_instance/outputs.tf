output "self_link" {
  value = module.public_mysql_instance.self_link
}

output "connection_name" {
  value = module.public_mysql_instance.connection_name
}

output "public_ip_address" {
  value = module.public_mysql_instance.public_ip_address
}

output "name" {
  value = module.public_mysql_instance.name
}
