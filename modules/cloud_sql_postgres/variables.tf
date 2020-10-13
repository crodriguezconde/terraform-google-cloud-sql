# ======================== DATA SOURCE DEFINITION ================= #

# It collects the different regions available within GCP.

data "google_compute_regions" "available" {
# project = var.project_id
}

# ========================= VARIABLE DEFINITION =================== #
# variable "project_id" {}
variable "name" {
  description = "Name of the Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "The MySQL version to use. Supported values are: POSTGRES_9_6, POSTGRES_10, POSTGRES_11, POSTGRES_12. It defaults to POSTGRES_10"
  type        = string
  default     = "POSTGRES_10"
}

variable "cloud_sql_region" {

  description = "The region where the Cloud SQL instance will reside"
  type        = string
}

variable "tier" {
  description = "Tier of the Cloud SQL instance. It defaults to db-g1-small"
  type        = string
  default     = "db-g1-small"
}

variable "activation_policy" {
  description = "This specifies when the instance should be active. Can be either ALWAYS, NEVER or ON_DEMAND. \n\n It defaults to ALWAYS if not set."
  type        = string
  default     = "ALWAYS"
  validation {
    condition     = contains(["ALWAYS", "NEVER", "ON_DEMAND"], var.activation_policy)
    error_message = "The value should be ALWAYS, NEVER or ON_DEMAND."

  }
}

variable "availability_type" {
  description = "The availability of the Cloud SQL instance. \n \n High Availability (HA) --> REGIONAL \n Single Zone (SZ) --> ZONAL. It defaults to ZONAL"
  type        = string
  default     = "ZONAL"
  validation {
    condition     = contains(["REGIONAL", "ZONAL"], var.availability_type)
    error_message = "The availability type should be either REGIONAL or ZONAL."

  }
}

variable "disk_size" {
  description = "(Optional, Default: 10) The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "(Optional, Default: PD_SSD) The type of data disk: PD_SSD or PD_HDD."
  type        = string
  default     = "PD_SSD"
  validation {
    condition     = contains(["PD_SSD", "PD_HDD"], var.disk_type)
    error_message = "The value should be either PD_SSD or PD_HDD."
  }

}

variable "disk_autoresize" {
  description = "(Optional, Default: true) Configuration to increase storage size automatically."
  type        = bool
  default     = true
  validation {
    condition     = contains([true, false], var.disk_autoresize)
    error_message = "Value must be set to either true or false."


  }
}

variable "point_in_time_recovery_enabled" {
  description = "True if Point-In-Time-Recovery is enabled."
  type        = string
  default     = false
}

variable "ipv4_enabled" {
  description = "Whether the Cloud SQL instance should be assigned a public IPV4 address."
  type        = bool
  default     = true
}

variable "vpc_network_id" {
  description = "The VPC network from which the Cloud SQL instance is accessible using private IP"
  type        = string
}

variable "require_ssl" {
  description = "Set to true if mysqld should default to REQUIRE X509 for users connnecting over IP"
  type        = bool
  default     = null
}

variable "maintenance_prefered_day" {
  description = "Day of the week (1-7), starting on Monday"
  type        = number
  default     = null
}

variable "maintenance_prefered_hour" {
  description = "Hour of the day (0-23). Ignored if maintenance_prefered_day not set"
  type        = number
  default     = null
}

variable "update_track" {
  description = "Receive updates before the maintenance (canary) or later (stable)."
  type        = string
  default     = ""
}

variable "backup_enabled" {
	description = "(Optional) True if backup configuration is enabled. If disabled, PITR should be disabled too."
	type = bool
	default = false
}
