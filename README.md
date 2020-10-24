# Cloud SQL module

This module is intended to be use to easily create Cloud SQL instances (MySQL, PostgreSQL & SQL Server).

## Overview

Cloud SQL is a fully-managed database service that helps you set up, maintain, manage, and administer your relational databases on Google Cloud Platform.

You can use Cloud SQL with MySQL, PostgreSQL.

Not sure what database option is right for you? Learn more about GCP's [database services](https://cloud.google.com/products/databases).

## Before you begin

- If you do not have one, create a new GCP project in the [Google Cloud Console]() and set up billing on that project.

- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) if you do not have it installed, as it will be needed in order to play with the modules.  

## Authentication

There are **two main ways** to authenticate when using Terraform with the Google provider:

1. The **easiest way** is to authenticate using the `gcloud` command as follows:

```
gcloud auth application-default login
```

[Here](https://cloud.google.com/sdk/gcloud/reference/auth/application-default) you will find further information on the command specified above. 

If you do not have it installed, gcloud can be installed following this [tutorial](https://cloud.google.com/sdk/docs/install). 

2. For a **production use-case**, you will want to use service account authentication, in other words, a [service account](https://cloud.google.com/docs/authentication/getting-started).

From [the service account key page in the Cloud Console](https://console.cloud.google.com/apis/credentials/serviceaccountkey) choose an existing account, or create a new one. 

Download the JSON key file. Name it something you can remember, and **store it somewhere secure on your machine.**

You supply the key to Terraform using the environment variable GOOGLE_APPLICATION_CREDENTIALS, setting the value to the location of the file, as follows:

```
export GOOGLE_APPLICATION_CREDENTIALS={{path}}
```

## Usage

1. **Clone** the GitHub repository by running the following command on your terminal:

```bash
$ git clone https://github.com/crodriguezconde/terraform-google-cloud-sql.git
```

2. Change directory to the examples folder to deploy an example Cloud SQL instance.

```bash
$ cd terraform-google-cloud-sql/modules/examples/
```

3. Choose one of the examples:

```bash
$ cd public_ip_mysql_instance/
```

4. Run `terraform init` to download the different modules as well as the Google provider.

5. Modify the `terraform.tfvars` file to modify the values of the variables to be passed to the module. 

6. `(Optional)` Run `terraform plan` to see the different resources that will be created.

7. Run `terraform apply` to create the infrastructure within your Google Cloud Platform project.

8. Run `terraform destroy` to undeploy the resources created.




