terraform {
  required_version = "~> 1.1.0"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.98.0"
    }
  }
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
}