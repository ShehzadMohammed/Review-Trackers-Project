$ErrorActionPreference = "STOP"
$env:TF_LOG="INFO"
Set-Location ./Terraform-Infrastructure
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
$env:SAN = (Get-Content ./storageaccname.txt).ForEach({ '"{0}"' -f $_ })
$env:SCA = (Get-Content ./storagecontname.txt).ForEach({ '"{0}"' -f $_ })
$env:PAK = (Get-Content ./primaryaccessskey.txt).ForEach({ '"{0}"' -f $_ })
$env:KEY = "terraform.tfstate"
#Formats and initializes the variables used in the migration process from local to azurerm 


(Get-Content ./versions.tf).Replace('"local"', '"azurerm"') | Set-Content ./versions.tf
#Changes the script backend to azurerm 

### NOTE : we can still can use the variables defined in powershell if need be in the same runner. 
