resource "azurerm_resource_group" "resource_group" {
  provider = azurerm
  name     = var.resource_group_name
  location = var.resource_group_location
}
# # AKS Virtual Network
# resource "azurerm_virtual_network" "aksvnet" {
#   name                = "rt-network"
#   location            = azurerm_resource_group.aks_rg.location
#   resource_group_name = azurerm_resource_group.aks_rg.name
#   address_space       = ["10.0.0.0/8"]
# }

# # Subnet
# resource "azurerm_subnet" "aks-default" {
#   name                 = "aks-default-subnet"
#   virtual_network_name = azurerm_virtual_network.aksvnet.name
#   resource_group_name  = azurerm_resource_group.aks_rg.name
#   address_prefixes     = ["10.240.0.0/16"]
# }
# # AKS Cluster

resource "azurerm_kubernetes_cluster" "rt_aks" {
  name                             = var.aks_cluster_name
  location                         = azurerm_resource_group.resource_group.location
  resource_group_name              = azurerm_resource_group.resource_group.name
  dns_prefix                       = var.aks_cluster_name
  zones                            = [1, 2, 3]
  kubernetes_version               = var.kubernetes_version
  http_application_routing_enabled = true
  tags = {
    Stage = "Deployment"
  }
  default_node_pool {
    name                = "systemnode"
    node_count          = var.number_of_nodes
    vm_size             = "Standard_DS2_v2"
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

