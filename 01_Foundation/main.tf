terraform {
  required_version = ">= 1.1.3"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.93"
    }
  }
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
}