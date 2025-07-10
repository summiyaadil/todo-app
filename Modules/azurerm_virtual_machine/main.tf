
# data "azurerm_network_security_group" "existing_nsg" {
#   name                = "existing-nsg-name"
#   resource_group_name = "existing-resource-group"
# }



resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  # network_security_group_id = data.azurerm_network_security_group.existing_nsg.id

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip.id 
  }

  tags = {
    environment = "Production"
  }
}




resource "azurerm_linux_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.vm_size
  
  admin_username      = data.azurerm_key_vault_secret.admin_username.value
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }
#     # custom_data = base64encode(<<EOF
# #!/bin/bash
# apt-get update
# apt-get install -y nginx
# systemctl enable nginx
# systemctl start nginx
# EOF
#   )
}