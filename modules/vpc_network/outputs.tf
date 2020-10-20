output "vpc_network_id" {
  description = "An identifier for the resource with format projects/{{project}}/global/networks/{{name}}"
  value       = google_compute_network.new_network.id
}

output "vpc_network_self_link" {
  description = "The URI of the created resource"
  value       = google_compute_network.new_network.self_link
}

output "vpc_network_gateway_ipv4" {
  description = "The gateway address for default routing out of the network. The value is selected by GCP."
  value       = google_compute_network.new_network.gateway_ipv4

}

