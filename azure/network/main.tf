variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "subnet_names" {
  type = list(string)
}
variable "address_prefixes" {
  type = list(string)
}
variable "address_space" {
  type = list(string)
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnets" {
  for_each             = toset(var.subnet_names)
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  value = { for s in azurerm_subnet.subnets : s.name => s.id }
}
