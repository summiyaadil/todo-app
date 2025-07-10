
resource "azurerm_mssql_server" "todo-server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.sql_username.value
  administrator_login_password = data.azurerm_key_vault_secret.sql_password.value
  
}