## It creates a new VPC network

resource "google_compute_network" "new_network" {
  name                            = var.vpc_network_name
  description                     = var.vpc_description
  auto_create_subnetworks         = var.vpc_auto_create_subnetworks_enabled
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create_enabled
}





