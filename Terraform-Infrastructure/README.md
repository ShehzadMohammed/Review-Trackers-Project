# AKS Cluster & Storage Account for Review Trackers
This Terraform module manages resources for a single Terra environment.
Each Terra application's resources are defined in its own module that this module references.

## Requirements

No requirements.

## Providers

azurerm version 3.13.0

local version 2.2.3

## Inputs

| Name | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aks_cluster_name | string | rt-py-kube | yes |
| kubernetes_version | string | 1.25.3 | yes | 
| number_of_nodes | number | 3 | yes | 
| resource_group_location | string | East US 2 | yes |
| resource_group_name | string | rt-infra | yes | 
| storage_container_name | string | remotestatecontainer | yes | 
| stroage_account_name | string | "" | yes | 

## Outputs 

No outputs. 