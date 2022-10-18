resource "azurerm_resource_group" "aks_resource_group" {
  provider = azurerm
  name     = var.aks_resource_group_name
  location = var.resource_group_location
}
resource "azurerm_resource_group" "node_resource_group" {
  provider = azurerm
  name     = var.node_resource_group_name
  location = var.resource_group_location
}
# AKS Cluster
resource "azurerm_kubernetes_cluster" "rt_aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks_resource_group.location
  resource_group_name = azurerm_resource_group.aks_resource_group.name
  dns_prefix          = var.aks_cluster_name
  node_resource_group = var.node_resource_group_name
  # zones                            = [1, 2, 3]
  kubernetes_version               = var.kubernetes_version
  http_application_routing_enabled = true
  tags = {
    Stage = "Deployment"
  }
  default_node_pool {
    name                = "systemnode"
    node_count          = var.number_of_nodes
    vm_size             = "Standard_B2s"
    type                = "VirtualMachineScaleSets"
    zones               = [1, 2, 3]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}
# Storage Account for State
resource "azurerm_storage_account" "remote_state_storage_account" {
  provider                 = azurerm
  name                     = var.storage_remote_name
  location                 = azurerm_resource_group.aks_resource_group.location
  resource_group_name      = azurerm_resource_group.aks_resource_group.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
resource "azurerm_storage_container" "conatiner_storage_account" {
  provider             = azurerm
  name                 = var.storage_container_name
  storage_account_name = azurerm_storage_account.remote_state_storage_account.name

}

