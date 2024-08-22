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
    node_count = 3
    vm_size    = "standard_d2s_v4"
    vnet_subnet_id = var.subnet_id
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    service_cidr      = "10.1.0.0/16"  # Ensure this does not overlap with your VNet or any other subnets
    dns_service_ip    = "10.1.0.10"    # Ensure this is within the service_cidr range
  }

  identity {
    type = "SystemAssigned"
  }
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
