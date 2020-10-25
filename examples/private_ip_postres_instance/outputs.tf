output "self_link" {
  description = "A self link of the newly created Cloud SQL instance."
  value       = module.private_postgres_instance.self_link
}

output "connection_name" {
  description = "The connection name for the Cloud SQL instance created. It has the following format: `[PROJECT_ID]:[REGION]:[INSTANCE_NAME]` "
  value       = module.private_postgres_instance.connection_name
}

output "private_ip_address" {
  description = "The private IPv4 address assigned to the Cloud SQL instance created."
  value       = module.private_postgres_instance.private_ip_address
}

output "name" {
  description = "Name of the Cloud SQL instance. "
  value       = module.private_postgres_instance.name
}
