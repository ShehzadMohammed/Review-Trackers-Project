terraform {
  backend "azurerm" {
    storage_account_name = ${{ secrets.INTIAL_STORAGE_ACCOUNT }}
    container_name       = "remotestatecontainer"
    key                  = "prod.terraform.tfstate"
    access_key = ${{ secrets.INTIAL_STORAGE_KEY }}
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.13.0"

    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }

  required_version = "1.2.4"


}
provider "azurerm" {

  features {}

}
