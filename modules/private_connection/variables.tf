variable "associated_vpc_network_id" {
	type = string
	description = "(Required) Name of the vpc network you would like to create a private connection with."
}

variable "allocated_ip_address_ranges" {
	type = list(string)
	description = "(Required) Name of the IP address range(s) to peer."
}
