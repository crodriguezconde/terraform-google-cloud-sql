output "self_link" {
  description = "The URI of the created Cloud SQL instance"
  value       = google_sql_database_instance.mysql_instance.self_link

}

output "connection_name" {
  description = "Represents the connection name used by other GCP products to connect to the Cloud SQL instance."
  value       = google_sql_database_instance.mysql_instance.connection_name
}

output "public_ip_address" {
  description = "Represents the public IPv4 address assigned to the Cloud SQL instance. "
  value       = google_sql_database_instance.mysql_instance.public_ip_address == "" ? null : google_sql_database_instance.mysql_instance.public_ip_address
}

output "private_ip_address" {
  description = "Represents the private IPv4 address assigned to the Cloud SQL instance."
  value       = google_sql_database_instance.mysql_instance.private_ip_address == "" ? null : google_sql_database_instance.mysql_instance.private_ip_address

}

output "name" {
  description = "Represents the name of the Cloud SQL instance."
  value       = google_sql_database_instance.mysql_instance.name
}

