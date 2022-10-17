# resource "local_file" "kubeconfig" {
#   depends_on = [azurerm_kubernetes_cluster.rt_aks]
#   filename   = "kubeconfig"
#   content    = azurerm_kubernetes_cluster.rt_aks.kube_config_raw
# }
