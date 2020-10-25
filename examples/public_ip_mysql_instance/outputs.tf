output "self_link" {
  description = "A self link of the newly created Cloud SQL instance."
  value       = module.public_mysql_instance.self_link
}

output "connection_name" {
  description = "The connection name for the Cloud SQL instance created. It has the following format: `[PROJECT_ID]:[REGION]:[INSTANCE_NAME]` "
  value       = module.public_mysql_instance.connection_name
}

output "public_ip_address" {
  description = "The public IPv4 address assigned to the Cloud SQL instance created."
  value       = module.public_mysql_instance.public_ip_address
}

output "name" {
  description = "Name of the Cloud SQL instance. "
  value       = module.public_mysql_instance.name
}
