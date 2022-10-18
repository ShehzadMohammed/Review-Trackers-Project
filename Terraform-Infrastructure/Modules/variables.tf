# Dependency Injection Principle
variable "aks_resource_group_name" {
  type        = string
  description = "Defines the name of the resource group containing AKS cluster"
}
variable "aks_cluster_name" {
  type        = string
  description = "Defines Cluster Name"
}
variable "kubernetes_version" {
  type        = string
  description = "Defines Kubernetes Version"
}
variable "node_resource_group_name" {
  type        = string
  description = "Defines the name of the resource group containing Nodes for the AKS cluster"
}
variable "number_of_nodes" {
  type        = number
  description = "Defines the number of nodes inside of the cluster"
}
variable "resource_group_location" {
  type        = string
  description = "Define the location of the resource group containing AKS cluster"
}
variable "storage_container_name" {
  type        = string
  description = "Container name inside the storage account especially important variable becuase multiple tfstate files are stored in the storage account then container names can be used to differentiate between them."
}
variable "storage_remote_name" {
  type        = string
  description = "A globally unique storage account name."
}
