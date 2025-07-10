
resource "azurerm_network_security_group" "nsg" {
  name                = var.name-nsg
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "test123"
    priority                   = var.priority-nsg
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
 }
    security_rule {
        name                       = "AllowHTTP"
        priority                   =  var.priority-nsg + 1
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

}