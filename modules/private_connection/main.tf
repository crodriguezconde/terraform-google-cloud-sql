resource "google_service_networking_connection" "private_connection" {
  network                 = var.associated_vpc_network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = var.allocated_ip_address_ranges
}
