resource "google_sql_database_instance" "mysql_instance" {
  name             = var.name
  database_version = var.database_version
  # It verifies whether the region input is a valid GCP region. If not, it defaults to us-central1.
  region = contains(data.google_compute_regions.available.names, var.cloud_sql_region) == true ? var.cloud_sql_region : data.google_compute_regions.available.names[17]

  master_instance_name = var.master_instance_name


  settings {
    tier              = var.tier
    activation_policy = var.activation_policy
    availability_type = var.availability_type
    disk_autoresize   = var.disk_autoresize
    disk_size         = var.disk_size
    disk_type         = var.disk_type
    backup_configuration {
      binary_log_enabled = var.binary_log_enabled
      enabled            = var.backup_enabled
    }
    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.vpc_network_id
      require_ssl     = var.require_ssl
    }
    maintenance_window {
      day          = var.maintenance_prefered_day
      hour         = var.maintenance_prefered_hour
      update_track = var.update_track
    }
  }
}

