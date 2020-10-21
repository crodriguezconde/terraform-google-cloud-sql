resource "google_compute_global_address" "allocated_ip_range" {
  name          = var.name
  description   = var.description
  address       = var.address
  purpose       = var.address_type == "EXTERNAL" ? null : var.purpose
  address_type  = var.address_type
  prefix_length = var.address_type == "EXTERNAL" ? null : var.prefix_length
  network       = var.address_type == "EXTERNAL" ? null : var.associated_vpc_network_id
}


