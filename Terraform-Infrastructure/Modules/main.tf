resource "azurerm_resource_group" "aks_resource_group" {
  provider = azurerm
  name     = var.aks_resource_group_name
  location = var.resource_group_location
  tags = {
    Type  = "ProjectDemo"
    Stage = "Deployment"
  }
}
# ** DECIDED TO USE MANAGED KUBERNETES NETWORKING USING SELF-MANAGED KUBERNETES NETWORKING IS NOT TIME EFFECTIVE! 
# AKS Virtual Network
# resource "azurerm_virtual_network" "aks_vnet" {
#   name                = "rt_network"
#   location            = azurerm_resource_group.aks_resource_group.location
#   resource_group_name = azurerm_resource_group.aks_resource_group.name
#   address_space       = ["10.0.0.0/8"]
#   depends_on = [
#     azurerm_resource_group.aks_resource_group
#   ]
#   tags = {
#     Type  = "ProjectDemo"
#     Stage = "Deployment"
#   }
# }

# Subnet
# resource "azurerm_subnet" "aks_default_subnet" {
#   name                 = "node_default_subnet"
#   virtual_network_name = azurerm_virtual_network.aks_vnet.name
#   resource_group_name  = azurerm_resource_group.aks_resource_group.name
#   address_prefixes     = ["10.240.0.0/16"]
#   depends_on = [
#     azurerm_resource_group.aks_resource_group,
#     azurerm_virtual_network.aks_vnet
#   ]
# }

# Public IP Prefix
# resource "azurerm_public_ip_prefix" "nat_prefix" {
#   name                = "nat_gateway"
#   resource_group_name = azurerm_resource_group.aks_resource_group.name
#   location            = azurerm_resource_group.aks_resource_group.location
#   ip_version          = "IPv4"
#   prefix_length       = 31
#   sku                 = "Standard"
#   zones               = ["1"]
#   depends_on = [
#     azurerm_resource_group.aks_resource_group
#   ]
# }

# Public NAT Gateway
# resource "azurerm_nat_gateway" "gw_aks" {
#   name                    = "natgw_aks"
#   resource_group_name     = azurerm_resource_group.aks_resource_group.name
#   location                = azurerm_resource_group.aks_resource_group.location
#   sku_name                = "Standard"
#   idle_timeout_in_minutes = 15
#   zones                   = ["1"]
#   depends_on = [
#     azurerm_resource_group.aks_resource_group
#   ]
#   tags = {
#     Type  = "ProjectDemo"
#     Stage = "Deployment"
#   }
# }

# resource "azurerm_nat_gateway_public_ip_prefix_association" "nat_ips" {
#   nat_gateway_id      = azurerm_nat_gateway.gw_aks.id
#   public_ip_prefix_id = azurerm_public_ip_prefix.nat_prefix.id
#   depends_on = [
#     azurerm_resource_group.aks_resource_group,
#     azurerm_nat_gateway.gw_aks,
#     azurerm_public_ip_prefix.nat_prefix
#   ]
# }
# 
# Assigning NAT Gateway to Subnet
# resource "azurerm_subnet_nat_gateway_association" "cluster_nat_gw" {
#   subnet_id      = azurerm_subnet.aks_default_subnet.id
#   nat_gateway_id = azurerm_nat_gateway.gw_aks.id
#   depends_on = [
#     azurerm_resource_group.aks_resource_group,
#     azurerm_subnet.aks_default_subnet,
#     azurerm_nat_gateway.gw_aks
#   ]
# }

# Load Balncer and Rules for Security and Access
# resource "azurerm_lb" "external_lb" {
#   name                = "aks_external_lb"
#   location            = azurerm_resource_group.aks_resource_group.location
#   resource_group_name = azurerm_resource_group.aks_resource_group.name
#   sku                 = "Standard"
#   frontend_ip_configuration {
#     name                = "ip_conf"
#     public_ip_prefix_id = azurerm_public_ip_prefix.nat_prefix.id
#   }
#   frontend_ip_configuration {
#     name = "ip_conf"
#   }
#   depends_on = [
#     azurerm_resource_group.aks_resource_group,
#     azurerm_public_ip_prefix.nat_prefix
#   ]
#   tags = {
#     Type  = "ProjectDemo"
#     Stage = "Deployment"
#   }
# }
# resource "azurerm_lb_nat_rule" "external_lb_rules" {
#   resource_group_name            = azurerm_resource_group.aks_resource_group.name
#   loadbalancer_id                = azurerm_lb.external_lb.id
#   name                           = "Access"
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 30201
#   frontend_ip_configuration_name = "ip_conf"
#   depends_on = [
#     azurerm_resource_group.aks_resource_group,
#     azurerm_lb.external_lb
#   ]
# }

# AkS Cluster
resource "azurerm_kubernetes_cluster" "rt_aks" {
  name                             = var.aks_cluster_name
  location                         = azurerm_resource_group.aks_resource_group.location
  resource_group_name              = azurerm_resource_group.aks_resource_group.name
  dns_prefix                       = var.aks_cluster_name
  node_resource_group              = var.node_resource_group_name
  kubernetes_version               = var.kubernetes_version
  http_application_routing_enabled = true

  tags = {
    Type  = "ProjectDemo"
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
  depends_on = [
    azurerm_resource_group.aks_resource_group,
  ]
}
# Storage Account for State
resource "azurerm_storage_account" "remote_state_storage_account" {
  provider                 = azurerm
  name                     = var.storage_remote_name
  location                 = azurerm_resource_group.aks_resource_group.location
  resource_group_name      = azurerm_resource_group.aks_resource_group.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = {
    Type  = "ProjectDemo"
    Stage = "Deployment"
  }
}
resource "azurerm_storage_container" "conatiner_storage_account" {
  provider             = azurerm
  name                 = var.storage_container_name
  storage_account_name = azurerm_storage_account.remote_state_storage_account.name

}

