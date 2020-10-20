output "private_connection_id" {
	description = "An identifier for the private connection created. "
	value = google_service_networking_connection.private_connection.id
}
