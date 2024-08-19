variable "resource_group_name" {}
variable "acr_name" {}
variable "location" {}

resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Basic"
  admin_enabled            = true
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
