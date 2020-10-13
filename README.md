# Cloud SQL module

This module is intended to be use to easily create Cloud SQL instances (MySQL, PostgreSQL & SQL Server).

## Overview

Cloud SQL is a fully-managed database service that helps you set up, maintain, manage, and administer your relational databases on Google Cloud Platform.

You can use Cloud SQL with MySQL, PostgreSQL, or SQL Server.

Not sure what database option is right for you? Learn more about GCP's [database services](https://cloud.google.com/products/databases).

## Table of contents

This module englobes different Cloud SQL instances in regards to their database version as well as the option to easily create new Cloud SQL users for your database on the fly.

Below you will find how this module is structured:

## **MySQL for Cloud SQL instance(s)**
  
   1. [**Usage of the MySQL module.**](#usage)
   2. [**Module Input Variables.**](#module-input-variables)

## PostgreSQL for Cloud SQL instance(s)


## Cloud SQL user(s)

- Adding a new Cloud SQL user to your existing Cloud SQL instance.

# MySQL for Cloud SQL instances

In this section, you will find further information on how to create a Cloud SQL MySQL instance using the module. 


## Usage

```hcl
module "mysql_instance" {
  source = "git::https://github.com/crodriguezconde/cloud_sql.git//modules/cloud_sql_mysql"
  name = "cloud-sql-mysql-instance"
  database_version = "MYSQL_5_7"
  cloud_sql_region = "us-east1"
}
```

Module Input Variables
----------------------

- `name`: (`Optional`)(`string`) The name of the Cloud SQL instance. If left empty, the module will generate a random name when creating the Cloud SQL instance.

- `database_version`: (`Optional`)(`string`) An optional MySQL version to use when creating a Cloud SQL instance. 

   **Default**: `MYSQL_5_6`

   **Allowed_values**: `MYSQL_5_6, MYSQL_5_7, MYSQL_8_0`

- `cloud_sql_region`: (`Optional`)(`string`) The region the Cloud SQL instance will reside in.

   
   [Here](https://cloud.google.com/sql/docs/mysql/locations) you will find the different region(s) available for Cloud SQL MySQL instances.
 
   **Default**: `us-central1`

- `tier`: (`Optional`)(`string`) Tier of the Cloud SQL MySQL instance. [Here](https://cloud.google.com/sql/pricing#2nd-gen-instance-pricing) you will find the list of available tier based on the region, as well as their pricing.

  **Default**: `db-n1-standard-1`

- `activation_policy`: (`Optional`)(`string`) This specifies whether the Cloud SQL MySQL instance should be active upon creation.

  **Default**: `ALWAYS`

  **Allowed_values**: `ALWAYS, NEVER, ON_DEMAND`

- `availability_type`: (`Optional`)(`string`) The availability of the Cloud SQL MySQL instance. This value is helpful when trying to maximize uptime within your service(s).

   Cloud SQL MySQL instances can be configured as **[High Availability (HA)](https://cloud.google.com/sql/docs/mysql/high-availability) or Single Zone (SZ)**.

  
  **Default**: `ZONAL`

  
  **Allowed_values**: `ZONAL, REGIONAL`

- `disk_size`: (`Optional`)(`number`) The size of the Cloud SQL instance data disk, in GB. 

  **⚠️** Please bear in mind the **size of a running instance cannot be reduce** but can be increased.
   
  **Default**: `1O GB`

- `disk_autoresize`: (`Optional`)(`bool`) Configuration to increase storage size automatically.

  **Default**: `true`

- `binary_log_enabled`: (`Optional`)(`bool`). True if you would like to enable binary logs on Cloud SQL MySQL instance.

  **Default**: `false`

- `ipv4_enabled`: (`Optional`)(`bool`). Whether the Cloud SQL instance should be assigned a public IPv4 IP address.

  **Default**: `true`

- `vpc_network_id`: (`Optional`)(`string`). The VPC network from which the Cloud SQL instance is accessible using Private IP address. 

  The format should be `projects/[project]/global/networks/[vpc_network]`

- `require_ssl `: (`Optional`)(`bool`). Set to true if mysqld should default to REQUIRE X509 for users connnecting over IP.

  **Default**: `false`


- `maintenance_prefered_day `: (`Optional`)(`number`). Day of the week (1-7), starting on Monday in order to schedule the maintenance preference.

- `maintenance_prefered_hour `: (`Optional`)(`number`). Hour of the day (0-23). Ignored if maintenance_prefered_day not set.

- `update_track `: (`Optional`)(`string`). Receive updates before the maintenance (canary) or later (stable)



