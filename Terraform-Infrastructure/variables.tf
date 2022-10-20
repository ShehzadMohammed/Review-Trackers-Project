# Dependency Injection Principle 
# Sorted A - Z
variable "aks_resource_group_name" {
  type        = string
  default     = "__RESOURCE_GROUP_NAME__"
  description = "Defines the name of the resource group containing AKS cluster"
}
variable "aks_cluster_name" {
  type        = string
  default     = "__AKS_CLUSTER_NAME__"
  description = "Defines Cluster Name"
}
variable "kubernetes_version" {
  type        = string
  default     = "1.24.6"
  description = "Defines Kubernetes Version"
}
variable "node_resource_group_name" {
  type        = string
  default     = "rtkube-node-group"
  description = "Defines the name of the resource group containing Nodes for the AKS cluster"
}
variable "number_of_nodes" {
  type        = number
  default     = 1
  description = "Defines the number of nodes inside of the cluster"
}
variable "resource_group_location" {
  type        = string
  default     = "__RESOURCE_GROUP_LOCATION__"
  description = "Define the location of the resource group containing AKS cluster"
}
variable "storage_container_name" {
  type        = string
  default     = "remotestatecontainer"
  description = "Container name inside the storage account especially important variable becuase multiple tfstate files are stored in the storage account then container names can be used to differentiate between them."
}
variable "storage_remote_name" {
  type        = string
  default     = "replace-variable"
  description = "A globally unique storage account name."
}
# Incramentally add more variables and outputs adhering to the Goldilocks Approach in this case to have a reliable project.
