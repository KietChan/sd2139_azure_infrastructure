provider "azurerm" {
  features {}
}

# Resource Group
module "resource_group" {
  source   = "./rg"
  rg_name  = var.resource_group_name
  location = var.location
}

output "created_resource_group_name" {
  value = module.resource_group.resource_group_name
}

# Azure Container Registry
module "acr" {
  source              = "./acr"
  resource_group_name = module.resource_group.resource_group_name
  acr_name            = var.acr_name
  location            = var.location
}

# Virtual Network
module "network" {
  source              = "./network"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  subnet_names        = var.subnet_names
  address_prefixes    = var.address_prefixes
  address_space       = var.address_spaces
}


# module "aks" {
#   source              = "./modules/aks"
#   resource_group_name = "myResourceGroup"
#   location            = "East US"
#   aks_name            = "myAKSCluster"
#   subnet_id           = module.network.subnet_ids["subnet1"]
# }

