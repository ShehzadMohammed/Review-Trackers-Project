# resource "local_file" "kubeconfig" {
#   depends_on = [azurerm_kubernetes_cluster.rt_aks]
#   filename   = "kubeconfig"
#   content    = azurerm_kubernetes_cluster.rt_aks.kube_config_raw
# }
output "PKM" {
  value       = azurerm_storage_account.remote_state_storage_account.primary_access_key
  description = "A primary access key is needed to access the backend to the newly created storage account on the second run-through of the script."
}
output "SAN" {
  value       = azurerm_storage_account.remote_state_storage_account.name
  description = "A globally unique storage account name is needed to identify the correct storage account."
}
output "SCA" {
  value       = azurerm_storage_container.conatiner_storage_account.name
  description = "Storage container name needed to move the TF state file into the correct container"
}
