variable "nic_name" {}
variable "resource_group_name" {}
variable "resource_group_location" {}
variable "vm_name" {}
variable "vm_size" {}


variable "image_publisher" {}
variable "image_offer" {}
variable "image_sku" {}
variable "subnet_name" {}
variable "virtual_network_name" {}
variable "pip_name" {}
 
 variable "key_vault_name" {
  description = "Name of the Key Vault to store secrets"
 }
variable "admin_username_secret_name" {
  description = "Name of the secret in Key Vault for the VM admin username"
}
variable "admin_password_secret_name" {
  description = "Name of the secret in Key Vault for the VM admin password"
}


