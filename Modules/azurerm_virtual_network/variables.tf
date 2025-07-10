variable "vnet_name"{}
variable "resource_group_location" {}
variable "resource_group_name" {}
variable "address_space" {
  type = list(string)
}

