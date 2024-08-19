variable "rg_name" {
  type        = string
}

variable "location" {
  type        = string
}

resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location
}

output "resource_group_name" {
  value       = azurerm_resource_group.example.name
}
