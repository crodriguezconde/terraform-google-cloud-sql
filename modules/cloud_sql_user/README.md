# Cloud SQL user module

This module is intended to easily create Cloud SQL user(s) using Terraform

## Usage 


```hcl
module "cloud_sql_user" {
  source = "git::https://github.com/crodriguezconde/terraform-google-cloud-sql.git//modules/cloud_sql_user"

  sql_user_name           = "${terraform.workspace}-terraform-user"
  cloud_sql_instance_name = "Name of the Cloud SQL instance"
  # The password for the user should not be hardcoded in the configuration file, but just for the sake of the example, the password here is empty.
  sql_user_password = "Password for Cloud SQL user"
}

```


Module Input Variables
----------------------

- `sql_user_name`: (`Required`)(`string`) The name of the Cloud SQL user you would like to create.

- `cloud_sql_instance_name`: (`Required`)(`string`). The name of the Cloud SQL instance the user will be created on.


- `sql_user_password`: (`Required`)(`string`) The password for the Cloud SQL user.

 ***Note: For Cloud SQL PostgreSQL instances, the password must be a value. It cannot be empty.***

   

