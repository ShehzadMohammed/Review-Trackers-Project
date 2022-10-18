module "rt_py_kubedeployment" {
  source                  = "./Modules" #String literal can not pass variable
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  kubernetes_version      = var.kubernetes_version
  number_of_nodes         = var.number_of_nodes
  aks_cluster_name        = var.aks_cluster_name
  storage_remote_name     = var.storage_remote_name
  storage_container_name  = var.storage_container_name
}
