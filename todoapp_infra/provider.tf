
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.33.0"
    }
  }
}

provider "azurerm" {
  features {
      key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
  # subscription_id = "3fed4955-0ed0-4498-a979-f538b3d003fa"
  subscription_id = "47b5b009-8fdd-461a-8ae1-b733c33e8f11"
}