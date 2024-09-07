terraform {
  required_version = ">= 1.9.5"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

### Another awesome Terraform ROOT module ###
### Let's take a break and play a round of Gwent ###