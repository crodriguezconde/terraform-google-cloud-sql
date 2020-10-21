output "name" {
  value = google_compute_global_address.allocated_ip_range.name
}

output "id" {
  description = "An identifier for the global address created with format projects/{{project}}/global/addresses/{{name}}"
  value       = google_compute_global_address.allocated_ip_range.id
}

output "creation_timestamp" {
  description = "Creation timestamp in RFC3339 text format."
  value       = google_compute_global_address.allocated_ip_range.creation_timestamp
}


