# AKS Cluster & Storage Account for Review Trackers
This Terraform module manages resources for a single Terra environment.
Each Terra application's resources are defined in its own module that this module references.

## Requirements

No requirements.

## Providers

terraform version 1.2.4

azurerm version 3.13.0

local version 2.2.3

## Inputs

| Name | Type | Default | Required |
|------|-------------|------|:--------:|
| aks_cluster_name | string | **ENVIORNMENT VARIABLE** | yes |
| kubernetes_version | string | 1.25.3 | yes | 
| number_of_nodes | number | 3 | yes | 
| resource_group_location | string | East US 2 | yes |
| resource_group_name | string | **ENVIORNMENT VARIABLE** | yes | 
| storage_container_name | string | remotestatecontainer | yes | 
| stroage_remote_name | string | autoupdates with date  | yes | 
| aks_cluster_name | string | rtkube-node-group  | yes | 

## Outputs 

| Name | Description |
|------|-------------|
| primaryaccesskey | This is the primary access key. On the first run through the script, this creates the txt file to store this information which is later used as a PowerShell variable to authenticate. | 
| storageaccname | This is the storage account name. On the first run through the script, this creates the txt file to store this information to identify the globally unique storage account. |
| storagecontname | This is the storage container name. On the first run through the script, this creates the txt file to store this information so the script can store the state file in the correct location. |
