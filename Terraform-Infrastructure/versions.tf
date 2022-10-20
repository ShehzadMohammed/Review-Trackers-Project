terraform {
  backend "local" {
    #############    ############    ###########    ##########
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
