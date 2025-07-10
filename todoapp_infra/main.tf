module "resource_group" {
  source = "../Modules/azurerm_resource_group"
  resource_group_name =  "todoapp-rg-s_a"
  resource_group_location = "uk west"
}
module "resource_group1" {
  source = "../Modules/azurerm_resource_group"
  resource_group_name =  "rg-Reading"
  resource_group_location = "uk west"
}

module "virtual_network" {
  depends_on = [ module.resource_group ]
  source = "../Modules/azurerm_virtual_network"

  resource_group_name = "todoapp-rg-s_a"
  resource_group_location = "uk west"
  vnet_name = "todoapp-vnet-s_a"
  address_space =["10.0.0.0/16"]
  }

module "subnet-frontend" {
    depends_on = [ module.virtual_network ]
    source = "../Modules/azurerm_subnet"

  resource_group_name = "todoapp-rg-s_a"
  virtual_network_name = "todoapp-vnet-s_a"
  subnet_name = "frontend-subnet"
  address_prefixes = ["10.0.1.0/24"]
  }

  module "subnet-backend" {
    depends_on = [ module.virtual_network ]
    source = "../Modules/azurerm_subnet"

  resource_group_name = "todoapp-rg-s_a"
  virtual_network_name = "todoapp-vnet-s_a"
  subnet_name = "backend-subnet"
  address_prefixes = ["10.0.2.0/24"]
  }

  module "frontend-vm"{
    depends_on = [ module.subnet-frontend, module.public_ip_frontend,module.resource_group, module.virtual_network, module.azurerm_key_vault, module.key_vault_password_frontend, module.key_vault_username_frontend ]
    source = "../Modules/azurerm_virtual_machine"
    nic_name = "frontend-nic"
    resource_group_name = "todoapp-rg-s_a"
    resource_group_location = "uk west"
    virtual_network_name = "todoapp-vnet-s_a"
    subnet_name = "frontend-subnet"
    key_vault_name = "todoapp-kv-sa"
    admin_username_secret_name = "frontend-username"
    admin_password_secret_name = "frontend-password"
    pip_name = "todoapp-public-ip-fe"
  
    vm_name = "frontend-vm"
    vm_size = "Standard_B1s"
    image_publisher = "Canonical"
    image_offer = "0001-com-ubuntu-server-jammy"
    image_sku = "22_04-lts"
  }
  module "backend-vm"{
    depends_on = [ module.subnet-backend , module.public_ip_backend,module.resource_group, module.key_vault_password_backend, module.key_vault_username_backend,module.azurerm_key_vault]
    source = "../Modules/azurerm_virtual_machine"
    nic_name = "backend-nic"
    resource_group_name = "todoapp-rg-s_a"
    resource_group_location = "uk west"
    virtual_network_name = "todoapp-vnet-s_a"
    subnet_name = "backend-subnet"
    key_vault_name = "todoapp-kv-sa"
    admin_username_secret_name = "backend-username"
    admin_password_secret_name = "backend-password"
    
    pip_name = "todoapp-public-ip-be"
  
    vm_name = "backend-vm"

    vm_size = "Standard_B1s"
    image_publisher = "Canonical"
    image_offer = "0001-com-ubuntu-server-focal"
    image_sku = "20_04-lts"
  }

  module "sql_server" {
    depends_on = [module.resource_group, module.azurerm_key_vault , module.key_vault_secret_sql_username, module.key_vault_secret_sql_password]
    
    source = "../Modules/azurerm_sql_server"
    sql_server_name = "todoapp-sql-server-sa"
    resource_group_name = "todoapp-rg-s_a"
    resource_group_location = "centralus"
    sql_server_admin_login = "sql-username"
    sql_server_admin_password = "sql-password"
    key_vault_name = "todoapp-kv-sa"
  }

  module "sql_database" {
    depends_on = [module.sql_server]
    sql_server_name = "todoapp-sql-server-sa"
  resource_group_name = "todoapp-rg-s_a"   
  source = "../Modules/azurerm_sql_database"
  name_sql_database = "todoappdb-sa"
   
  }           

 module "public_ip_frontend" {
    depends_on = [ module.resource_group ]
    source = "../Modules/azurerm_public_ip"
    public_ip_name = "todoapp-public-ip-fe"
    resource_group_name = "todoapp-rg-s_a"
    resource_group_location = "uk west"
  }
module "public_ip_backend" {
    depends_on = [ module.resource_group ]
    source = "../Modules/azurerm_public_ip"
    public_ip_name = "todoapp-public-ip-be"
    resource_group_name = "todoapp-rg-s_a"
    resource_group_location = "uk west"
  }

module "azurerm_key_vault" {
  depends_on = [ module.resource_group ]
  source = "../Modules/azurerm_key_vault"
  key_vault_name = "todoapp-kv-sa"
  resource_group_name = "todoapp-rg-s_a"
  resource_group_location = "uk west"
 
}
 
module "key_vault_secret_sql_username" {
  depends_on = [ module.azurerm_key_vault ]
  source = "../Modules/azurerm_keyvault_secret"
  key_vault_name = "todoapp-kv-sa"
  resource_group_name = "todoapp-rg-s_a"
  secret_name ="sql-username"
  secret_value = "sqladmin"
}

module "key_vault_secret_sql_password" {
  depends_on = [ module.azurerm_key_vault ]
  source = "../Modules/azurerm_keyvault_secret"
  key_vault_name = "todoapp-kv-sa"
  resource_group_name = "todoapp-rg-s_a"
  secret_name ="sql-password"
  secret_value = "Pakistan1947"
}

module "key_vault_username_frontend" {
  depends_on = [ module.azurerm_key_vault ]
  source = "../Modules/azurerm_keyvault_secret"
  key_vault_name = "todoapp-kv-sa"
  resource_group_name = "todoapp-rg-s_a"
  secret_name ="frontend-username"
  secret_value = "frontendadmin"
}

module "key_vault_password_frontend" {
  depends_on = [ module.azurerm_key_vault ]
  source = "../Modules/azurerm_keyvault_secret"
  key_vault_name = "todoapp-kv-sa"
  resource_group_name = "todoapp-rg-s_a"
  secret_name ="frontend-password"
  secret_value = "Pakistan1947"
}

module "key_vault_username_backend" {
  depends_on = [ module.azurerm_key_vault ]
  source = "../Modules/azurerm_keyvault_secret"
  key_vault_name = "todoapp-kv-sa"
  resource_group_name = "todoapp-rg-s_a"
  secret_name ="backend-username"
  secret_value = "backendadmin"
}

module "key_vault_password_backend" {
  depends_on = [ module.azurerm_key_vault ]
  source = "../Modules/azurerm_keyvault_secret"
  key_vault_name = "todoapp-kv-sa"
  resource_group_name = "todoapp-rg-s_a"
  secret_name ="backend-password"
  secret_value = "Pakistan1947"
}