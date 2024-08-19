variable "resource_group_name" {}
variable "location" {}
variable "aks_name" {}
variable "subnet_id" {}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.aks_name}"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
