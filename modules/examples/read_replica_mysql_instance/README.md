# How to create a Public Cloud SQL MySQL read replica instance

This example demonstrates how to create a [Cloud SQL MySQL read replica instance](https://cloud.google.com/sql/docs/mysql/replication).

It also creates a new [Cloud SQL user](https://cloud.google.com/sql/docs/mysql/create-manage-users) since **Terraform deletes the default user** upon creation for security reasons, as described [here.](https://www.terraform.io/docs/providers/google/r/sql_database_instance.html)

## Introduction

### Why using read replicas?

You use a read replica **to offload work from a Cloud SQL instance**. 

The read replica is an exact copy of the primary instance. Therefore, data and other changes on the primary instance are **updated in almost real time on the read replica.**

### Can I write to the database when using a read replica?

Read replicas **are read-only**; you cannot write to them. 

The read replica processes queries, read requests, and analytics traffic, thus reducing the load on the primary instance.

### Can I configure a read replica with a greater tier than the primary?

Read replicas can have more CPUs and memory than the primary instance, but they **cannot have less**. 

### How many read replicas can I have per Cloud SQL primary instance?

You can have **up to 10 read replicas** per primary instance.

## Usage

1. `terraform init -upgrade`
2. `terraform apply`

If you want to edit or change the variable's name, such as the Cloud SQL MySQL instance name, just edit the `main.tf` and modify the variable itself.

Afterwards, if you have already initialize terraform, just run `terraform apply` and you will be ready to go!

## How can I connect to my Cloud SQL MySQL instance once it is created?

To be able to connect to your Cloud SQL MySQL instance, you will need the following parameter(s) from your newly created Cloud SQL MySQL instance.

- Cloud SQL [username](https://cloud.google.com/sql/docs/mysql/create-manage-users#listing_users) & password.
- Cloud SQL MySQL instance name, that can be found running the following [command](https://cloud.google.com/sdk/gcloud/reference/sql/instances/list) on your Cloud Shell:

Once you have all the above parameter(s), you could connect to your Cloud SQL MySQL instance via `gcloud` command, as follows:

`gcloud sql connect [INSTANCE_NAME] --user=[CLOUD_SQL_USERNAME] `

[Here](https://cloud.google.com/sdk/gcloud/reference/sql/connect) you will find further information in regards to the `gcloud` command shown above.

Once the command has been run, it will prompt you to enter your password. Once it has been introduced, you should be able to run SQL statements within your newly created Cloud SQL MySQL instance!

## Dependencies

In order to successfully create a new Cloud SQL MySQL instance, the following modules will be installed upon running `terraform init -upgrade`:

- `terraform-google-cloud-sql.git//modules/cloud_sql_mysql` responsible for creating the actual Cloud SQL MySQL instance. 
- `terraform-google-cloud-sql.git//modules/cloud_sql_user` responsible for creating a new Cloud SQL user upon instance's creation in order to be able to connect to the Cloud SQL MySQL instance.





