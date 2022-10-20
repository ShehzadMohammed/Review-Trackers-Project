$ErrorActionPreference = "STOP"
$env:TF_LOG="INFO"
Set-Location Terraform-Infrastructure
Get-Date -Format "HHmmMMddyyyy" > dateandtime.txt
$date = (Get-Content ./dateandtime.txt)
$stringappend = "rtpystorage"
$paramforstr = $stringappend + $date
#Appends Storage Account Name with date and time

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
$KEY = "terraform.tfstate"
#Formats and initializes the variables used in the migration process from local to azurerm 

$ARM_ACCESS_KEY=$(az storage account keys list --resource-group rt-intra --account-name "$SAN" --query '[0].value' -o tsv)
# "resource_group_name=rt-infra" 
(Get-Content ./versions.tf).Replace('"local"', '"azurerm"') | Set-Content ./versions.tf
# Changes the script backend to azurerm 
terraform init -migrate-state -backend-config="storage_account_name=$SAN" -backend-config="container_name=$SCA" -backend-config="access_key=$PAK" -backend-config="use_msi=false" -backend-config="use_microsoft_graph=false" -backend-config="key=$KEY" --auto-approve
# Initiates the migration & Configuring backend via the variables defined earlier

terraform plan
terraform apply --auto-approve

Remove-Item storagecontname.txt, storageaccname.txt, dateandtime.txt, primaryaccessskey.txt, terraform.tfstate, .\.terraform.lock.hcl, terraform.tfstate.backup,.terraform -Recurse -Force -Confirm:$false
#Changes the script backend to azurerm 

### NOTE : we can still can use the variables defined in powershell if need be in the same runner. 
