terraform {
  required_version = ">= 1.5.0"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.83.0"
    }
  }
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

### Another awesome Terraform ROOT module ###
### Let's take a break and play a round of Gwent ###