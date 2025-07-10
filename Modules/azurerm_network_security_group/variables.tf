variable "name-nsg" {
  type        = string
  description = "The name of the Network Security Group."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Network Security Group will be created."
}
variable "resource_group_location" {
  type        = string
  description = "The location of the resource group where the Network Security Group will be created."
}
variable "priority-nsg" {
  type        = number
  description = "The priority of the security rule in the Network Security Group."
  default     = 100
}