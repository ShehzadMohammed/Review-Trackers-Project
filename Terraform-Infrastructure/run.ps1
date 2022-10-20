$ErrorActionPreference = "STOP"
Set-Location Terraform-Infrastructure
Get-Date -Format "HHmmMMddyyyy" > dateandtime.txt
$date = (Get-Content ./dateandtime.txt)
$stringappend = "rtpystorage"
$paramforstr = $stringappend + $date
#Appends Storage Account Name with date and time

(Get-Content ./variables.tf).Replace('replace-variable', $paramforstr) | Set-Content ./variables.tf #This sets the variable to the input given

terraform init -backend-config="access_key="${{ secrets.INTIAL_STORAGE_KEY }}""  -backend-config="storage_account_name="${{ secrets.INTIAL_STORAGE_ACCOUNT }}""
terraform plan 
terraform apply --auto-approve