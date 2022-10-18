$ErrorActionPreference = "STOP"
Set-Location ./Terraform-Infrastructure
Get-Date -Format "HHmmMMddyyyy" > dateandtime.txt
$date = (Get-Content ./dateandtime.txt)
$stringappend = "rtpystorage"
$paramforstr = $stringappend + $date
#Takes Parameter1 for Storage Account Name

(Get-Content ./variables.tf).Replace('replace-variable', $paramforstr) | Set-Content ./variables.tf #This sets the variable to the input given

terraform init
terraform plan 
terraform apply --auto-approve
terraform output -raw storageaccname > storageaccname.txt
terraform output -raw storagecontname > storagecontname.txt
terraform output -raw primaryaccesskey > primaryaccessskey.txt
#Builds TF and outputs certain data to txt files

# $SAS = (Get-Content ./SAStoken.txt).ForEach({ '"{0}"' -f $_ })
$SAN = (Get-Content ./storageaccname.txt).ForEach({ '"{0}"' -f $_ })
$SCA = (Get-Content ./storagecontname.txt).ForEach({ '"{0}"' -f $_ })
$PAK = (Get-Content ./primaryaccessskey.txt).ForEach({ '"{0}"' -f $_ })
$key = "terraform.tfstate"
#Formats and initializes the variables used in the migration process from local to azurerm 


(Get-Content ./versions.tf).Replace('"local"', '"azurerm"') | Set-Content ./versions.tf
#Changes the script backend to azurerm 
terraform init -migrate-state -force-copy -backend-config="storage_account_name=$SAN" -backend-config="container_name=$SCA" -backend-config="access_key=$PAK" -backend-config="key=$key"

#Initiates the migration & Configuring backend via the variables defined earlier
terraform plan
terraform apply --auto-approve
#Finishes the process with the new backend in azure storage account...
Remove-Item SAN.txt, PAK.txt, terraform.tfstate, .\.terraform.lock.hcl, .terraform -Recurse -Force -Confirm:$false
(Get-Content ./variables.tf).Replace($storageName, 'replace-variable') | Set-Content ./variables.tf
(Get-Content ./versions.tf).Replace('"azurerm"', '"local"') | Set-Content ./versions.tf
#This removes the unnecessary files from the local environment
#Two changes over the lifecyle of this script
### NOTE : we can still can use the variables defined in powershell if need be. 
