# VPC network module

This module is intended to be use to create a new Virtual Private Cloud (VPC) network within GCP.

## Overview

A **Virtual Private Cloud (VPC) network** is a virtual version of a physical network, implemented inside of Google's production network.

Projects **can contain multiple VPC networks.** Unless you create an organizational policy that prohibits it, new projects start with a default network (an auto mode VPC network) that has one subnetwork (subnet) in each region.

## Usage

```hcl
module "vpc_network" {
  source           = "git::https://github.com/crodriguezconde/vpc_network.git"
  vpc_network_name = "example-vpc"
  vpc_description = "Test VPC created using the VPC network module"
  routing_mode = "REGIONAL"
}
```

Module Input Variables
----------------------

- `vpc_network_name`: (`string`) Name of the Virtual Private Cloud (VPC) network.

- `vpc_description`: (`string`) An optional description of the VPC network created. 

   **Default**:`VPC network created using Terraform.`

- `vpc_auto_create_subnetworks_enabled`: (`bool`) When set to `true`, it will create a subnetwork for each region automatically across the `10.128.0.0/9`.
 
  **Default**: `false`

- `routing_mode`: (`string`) If set to `REGIONAL`, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to `GLOBAL`, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. 

  Possible values are `REGIONAL` and `GLOBAL`.

  **Default**: `REGIONAL`

- `delete_default_routes_on_create_enabled`: (`bool`) If set to `true`, default routes (`0.0.0.0/0`) will be deleted immediately after the network creation.

  **Default**: `false`

  Be careful when setting [default routes](https://cloud.google.com/vpc/docs/vpc#system-generated-routes), as they define a path for traffic to leave the VPC network. It provides general internet access to VMs and it also provides the typical path for Private Google Access.

Module Output(s) Variable(s)
------

- `vpc_network_id`: (`string`) An identifier for the VPC network created with format `projects/{{project}}/global/networks/{{name}}`

- `vpc_network_self_link`: (`string`) The URI of the VPC network created.

- `vpc_network_gateway_ipv4`: (`string`) The gateway address for default routing out of the network. The value is selected by GCP.

