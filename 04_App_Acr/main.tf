terraform {
  required_version = "~> 1.2.0"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.1"
    }
  }
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
}