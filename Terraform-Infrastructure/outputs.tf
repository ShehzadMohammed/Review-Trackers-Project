output "primaryaccesskey" {
  depends_on  = [module.rt_py_kubedeployment]
  value       = module.rt_py_kubedeployment.PKM
  sensitive   = true
  description = "This is the primary access key. On the first run through the script, this creates the txt file to store this information which is later used as a PowerShell variable to authenticate."
}
output "storageaccname" {
  depends_on  = [module.rt_py_kubedeployment]
  value       = module.rt_py_kubedeployment.SAN
  sensitive   = false
  description = "This is the storage account name. On the first run through the script, this creates the txt file to store this information to identify the globally unique storage account."
}
output "storagecontname" {
  depends_on  = [module.rt_py_kubedeployment]
  value       = module.rt_py_kubedeployment.SCA
  sensitive   = false
  description = "This is the storage container name. On the first run through the script, this creates the txt file to store this information so the script can store the state file in the correct location."
}
