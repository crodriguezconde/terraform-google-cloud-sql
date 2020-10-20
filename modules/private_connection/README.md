# Private connection module

This module is intended for creating private connection(s) against GCP's service provider(s).

This module can be use when creating a Cloud SQL instance with a private IP address or any product that needs a private connection in order to function properly within GCP.

## Overview

The private connection **establishes a VPC Network Peering connection** between your VPC network and the service producer's network.

Private connections are a **one-to-one relationship** between your VPC network and a service producer. 

If a single service producer offers multiple services, you only need one private connection for all of the producer's services.

If you connect to multiple service producers, use a unique allocation for each service producer. 

## Usage

```hcl
module "private_connection" {
  source = "git::https://github.com/crodriguezconde/private_connection.git"
  associated_vpc_network_id  = "Name of the VPC network to create a private connection with."
  allocated_ip_address_ranges = ["example-allocation"] 
}
```

Module Input Variables
----------------------

- `associated_vpc_network_id`: (`Required`)(`string`) Name of the Virtual Private Cloud (VPC) network you want to create a private connection against. 

- `allocated_ip_address_ranges`: (`Required`)(`list(string)`) Name of the allocated IP address range(s) pertaining to the VPC network.

Module Output(s) Variable(s)
------

- `private_connection_id`: (`string`) An identifier for the private connection created. 

Related Documentation
------
- [**How to configure a private connection within GCP.**](https://cloud.google.com/vpc/docs/configure-private-services-access#creating-connection)
- [**API**](https://cloud.google.com/service-infrastructure/docs/service-networking/reference/rest/v1/services.connections) for establishing private connections.
