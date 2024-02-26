terraform {
  backend "azurerm" {
    resource_group_name  = "storage_resources"
    storage_account_name = "statestorage271"
    container_name       = "tfstatecontainerstate"
    key                  = "terraform.tfstatecontainerstate"
  }
}