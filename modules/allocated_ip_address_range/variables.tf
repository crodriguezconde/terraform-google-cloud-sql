variable "name" {
  description = "Name of the allocated IP range"
  type        = string
}

variable "description" {
  type        = string
  description = "An optional description for the allocated IP address range created."
  default     = "Allocated IP address range created using a Terraform module."
}

variable "address" {
  type        = string
  description = "The IP address or the beginning of the address range represented by the allocated IP address range. \n If not specified, GCP chooses a valid IP address for you."
	default = null
}

variable "purpose" {
  description = "This should only be set when using an INTERNAL address. Possible values when using INTERNAL addresses are VPC_PEERING"
  type        = string
}

variable "address_type" {
  description = "The type of the address to reserve. Possible values are EXTERNAL or INTERNAL"
  type        = string
}

variable "prefix_length" {
  description = "The prefix length of the IP range. If not present, it means the address field is a single IP address. This field is not applicable if address_type=EXTERNAL."
  type        = string
}

variable "associated_vpc_network_id" {
  description = "The URL of the network in which to reserve an INTERNAL IP range. The IP range must be in RFC1918 space. This field is not applicable if address_type=EXTERNAL."
  type        = string
}
