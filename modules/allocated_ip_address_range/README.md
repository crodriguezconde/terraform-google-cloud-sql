# IP allocation range module

This module is intended to easily create IP addresses allocation range(s) within a VPC network using Terraform.

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

- `name`: (`Required`)(`string`) The name of the allocated IP address range.

- `description`: (`Optional`)(`string`). An optional description for the allocated IP address range created.

  **Default**: `"An allocated IP address range created using a Terraform module"`


- `address`: (`Optional`)(`string`). The IP address or the beginning of the address range represented by the allocated IP address range. If not specified, GCP chooses a valid IP address for you.

- `purpose`: (`Required`)(`string`). This should only be set when using an INTERNAL address. 

  **Allowed values**: `VPC_PEERING`

- `address_type`: (`Required`)(`string`). The type of the address to reserve.

  **Allowed values**: `EXTERNAL, INTERNAL`

- `prefix_length`: (`Required`)(`string`). The prefix length of the IP range. If not present, it means the address field is a single IP address. This field is not applicable if address_type=EXTERNAL.

- `associated_vpc_network_id `: (`Required`)(`string`). The URL of the network in which to reserve an INTERNAL IP range. The IP range must be in RFC1918 space. This field is not applicable if address_type=EXTERNAL.

  The format should be of the type `projects/{{project}}/global/networks/{{name}}`

## Module Output variables

- `name`: (`string`). The name of the allocated IP address range.

- `id`: (`string`). An identifier for the global address created with format `projects/{{project}}/global/addresses/{{name}}`

- `creation_timestamp`: (`string`). Creation timestamp in RFC3339 text format.
   
## Related documentation

- How to create an [IP address allocation range](https://cloud.google.com/vpc/docs/configure-private-services-access#allocating-range)
