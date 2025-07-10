data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name

}

data "azurerm_key_vault_secret" "sql_username" {
  name         = var.sql_server_admin_login
  key_vault_id = data.azurerm_key_vault.kv.id
}


data "azurerm_key_vault_secret" "sql_password" {
  name         = var.sql_server_admin_password
  key_vault_id = data.azurerm_key_vault.kv.id
}
