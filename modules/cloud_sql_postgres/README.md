# Cloud SQL PostgreSQL instance module

This module is intended to easily create Cloud SQL  PostgreSQL instances using Terraform.

## Usage 


```hcl
module "postgres_instance" {
  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_postgres"
  name = "cloud-sql-postgres-instance"
  database_version = "POSTGRES_10"
  cloud_sql_region = "us-east1"
}
```


Module Input Variables
----------------------

- `name`: (`Optional`)(`string`) The name of the Cloud SQL instance. If left empty, the module will generate a random name when creating the Cloud SQL instance.

- `database_version`: (`Optional`)(`string`) An optional PostgreSQL version to use when creating a Cloud SQL instance. 

   **Default**: `POSTGRES_10`

   **Allowed_values**: `POSTGRES_9_6, POSTGRES_10, POSTGRES_11, POSTGRES_12`

- `cloud_sql_region`: (`Optional`)(`string`) The region the Cloud SQL instance will reside in.

   
   [Here](https://cloud.google.com/sql/docs/postgres/locations) you will find the different region(s) available for Cloud SQL PostgreSQL instances.
 
   **Default**: `us-central1`

- `tier`: (`Optional`)(`string`) Tier of the Cloud SQL PostgreSQL instance. [Here](https://cloud.google.com/sql/pricing#pg-pricing) you will find the list of available tier based on the region, as well as their pricing.

  **Default**: `db-g1-small`

- `activation_policy`: (`Optional`)(`string`) This specifies whether the Cloud SQL PostgreSQL instance should be active upon creation.

  **Default**: `ALWAYS`

  **Allowed_values**: `ALWAYS, NEVER, ON_DEMAND`

- `availability_type`: (`Optional`)(`string`) The availability of the Cloud SQL PostgreSQL instance. This value is helpful when trying to maximize uptime within your service(s).

   Cloud SQL PostgreSQL instances can be configured as **[High Availability (HA)](https://cloud.google.com/sql/docs/postgres/high-availability) or Single Zone (SZ)**.

  
  **Default**: `ZONAL`

  
  **Allowed_values**: `ZONAL, REGIONAL`

- `disk_size`: (`Optional`)(`number`) The size of the Cloud SQL instance data disk, in GB. 

  **⚠️** Please bear in mind the **size of a running instance cannot be reduce** but can be increased.
   
  **Default**: `1O GB`

- `disk_autoresize`: (`Optional`)(`bool`) Configuration to increase storage size automatically.

  **Default**: `true`

- `point_in_time_recovery_enabled`: (`Optional`)(`bool`). True if you would like to enable [PITR](https://cloud.google.com/sql/docs/postgres/backup-recovery/pitr) on Cloud SQL PostgreSQL instance.

  **Default**: `false`

- `backup_enabled`:(`Optional`)(`bool`). True if backup configuration is enabled. If disabled, PITR should be disabled too.

  **Default**: `false`

- `ipv4_enabled`: (`Optional`)(`bool`). Whether the Cloud SQL instance should be assigned a public IPv4 IP address.

  **Default**: `true`

- `vpc_network_id`: (`Optional`)(`string`). The VPC network from which the Cloud SQL instance is accessible using Private IP address. 

  The format should be `projects/[project]/global/networks/[vpc_network]`


- `maintenance_prefered_day `: (`Optional`)(`number`). Day of the week (1-7), starting on Monday in order to schedule the maintenance preference.

- `maintenance_prefered_hour `: (`Optional`)(`number`). Hour of the day (0-23). Ignored if maintenance_prefered_day not set.

- `update_track `: (`Optional`)(`string`). Receive updates before the maintenance (canary) or later (stable)

- `master_instance_name`:(`Optional`)(`string`). Name of the Cloud SQL PostgreSQL master instance you would like to attach a read replica.

  ***Note: When using `master_instance_name`, the master instance should have both binary log(s) or PITR and backup(s) enabled.***

## Module Output variables

- `self_link`:(`string`). The URI of the Cloud SQL instance created.

- `connection_name`:(`string`). Represents the connection name used by other GCP products to connect to the Cloud SQL instance.

 It has the following format: `[PROJECT_ID]:[REGION]:[INSTANCE_NAME]`


- `public_ip_address`:(`string`). Represents the public IPv4 address assigned to the Cloud SQL instance. 

- `private_ip_address`:(`string`). Represents the private IPv4 address assigned to the Cloud SQL instance. 

- `name`:(`string`). Represents the name of the Cloud SQL instance.
