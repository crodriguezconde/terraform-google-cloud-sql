# How to create a Private Cloud SQL PostgreSQL read replica instance

This example demonstrates how to create a [Cloud SQL PostgreSQL read replica instance](https://cloud.google.com/sql/docs/postgres/replication) configured for [private IP address](https://cloud.google.com/sql/docs/postgres/configure-private-ip) access.

It also creates a new [Cloud SQL user](https://cloud.google.com/sql/docs/postgres/create-manage-users) since **Terraform deletes the default user** upon creation for security reasons, as described [here.](https://www.terraform.io/docs/providers/google/r/sql_database_instance.html)

***Note: for Cloud SQL PostgreSQL users, the password may not be empty, or else it will error out when creating it.***

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

## How it works

[Here](https://cloud.google.com/sql/docs/postgres/configure-private-services-access) you will find further information on how creating a Cloud SQL instance with Private IP address works, but it could be summarized in the following steps:

1. We **create a new VPC network** (in case you do not have any apart from the `default` one) that later will be used to create both the allocation IP range as well as the VPC peering against the service producer. 
2. We **allocate a new IP address range** within the VPC network created that it will be used to VPC peer the VPC network on our project against the service producer.
3. After we created an allocated range, we can **create a private connection to a service producer**. The private connection establishes a VPC Network Peering connection between your VPC network and the service producer's network.
4. Now we can **create a new Cloud SQL PostgreSQL instance using a private IP address** from the allocation range configured in step 2 within the VPC network created on step 1.
5. Finally, we can create a **new Cloud SQL PostgreSQL read replica instance** attached to the primary instance.

### Notes

- A replica **[inherits its private IP status from its primary instance](https://cloud.google.com/sql/docs/postgres/private-ip#quick-reference)**. 
- You **cannot configure private IP directly on a replica.**

## Usage

1. `terraform init -upgrade`
2. `terraform apply`

If you want to edit or change the variable's name, such as the Cloud SQL PostgreSQL instance name, just edit the `main.tf` and modify the variable itself.

Afterwards, if you have already initialize terraform, just run `terraform apply` and you will be ready to go!

## How can I connect to my Cloud SQL PostgreSQL instance once it is created?

To be able to connect to your Cloud SQL PostgreSQL instance, you will need the following parameter(s) from your newly created Cloud SQL PostgreSQL instance.

- Cloud SQL [username](https://cloud.google.com/sql/docs/postgres/create-manage-users#listing_users) & password.
- Cloud SQL PostgreSQL instance name, that can be found running the following [command](https://cloud.google.com/sdk/gcloud/reference/sql/instances/list) on your Cloud Shell:

Once you have all the above parameter(s), you could connect to your Cloud SQL PostgreSQL instance via `gcloud` command, as follows:

`gcloud sql connect [INSTANCE_NAME] --user=[CLOUD_SQL_USERNAME] `

[Here](https://cloud.google.com/sdk/gcloud/reference/sql/connect) you will find further information in regards to the `gcloud` command shown above.

Once the command has been run, it will prompt you to enter your password. Once it has been introduced, you should be able to run SQL statements within your newly created Cloud SQL PostgreSQL instance!

## Dependencies

In order to successfully create a new Cloud SQL PostgreSQL instance, the following modules will be installed upon running `terraform init -upgrade`:

- `terraform-google-cloud-sql.git//modules/cloud_sql_postgres` responsible for creating the actual Cloud SQL PostgreSQL instance. 
- `terraform-google-cloud-sql.git//modules/cloud_sql_user` responsible for creating a new Cloud SQL user upon instance's creation in order to be able to connect to the Cloud SQL PostgreSQL instance.
- `vpc_network.git`responsible for creating a VPC network that will allocate the Cloud SQL PostgreSQL instance's private IP address.
- `allocated_ip_address_range.git` responsible for allocating an IP address range in order to be used later by the Cloud SQL PostgreSQL instance.
- `private_connection.git` responsible for creating a VPC peering between your project and the service project, so we can later use Private IP with our Cloud SQL instance. 

## Related documentation

- [Replication in Cloud SQL](https://cloud.google.com/sql/docs/postgres/replication). 
- [Cloud SQL read replica instance's billing](https://cloud.google.com/sql/docs/postgres/replication#billing).
- Main [issues](https://cloud.google.com/sql/docs/postgres/replication/create-replica#troubleshooting) when creating a read replica instance.





