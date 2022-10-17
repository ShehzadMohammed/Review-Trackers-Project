resource "azurerm_resource_group" "resource_group" {
  provider = azurerm
  name     = var.resource_group_name
  location = var.resource_group_location
}
# AKS Cluster

resource "azurerm_kubernetes_cluster" "rt_aks" {
  name                = var.aks_cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = var.aks_cluster_name
  default_node_pool {
    name                = "system-node"
    node_count          = var.number_of_nodes
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.0.0.0/16"
  }
  addon_profile {
    http_application_routing_enabled {
      enabled = true
    }
  }
}
resource "azurerm_storage_account" "remote_state_storage_account" {
  provider                 = azurerm
  name                     = var.storage_remote_name
  location                 = azurerm_resource_group.resource_group.location
  resource_group_name      = azurerm_resource_group.resource_group.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
resource "azurerm_storage_container" "conatiner_storage_account" {
  provider             = azurerm
  name                 = var.storage_container_name
  storage_account_name = azurerm_storage_account.remote_state_storage_account.name

}
# Storage Account for State
