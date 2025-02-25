### Data Sources ###
data "azurerm_client_config" "current" {}

##################################################
# FOUNDATIONAL RESOURCES                         #
##################################################

# Declare variables to verify if RG exists
variable "resource_group_name" {
  description = "The name of the resource group to verify"
  type        = string
  default     = ""
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "UKSouth"
}

# Check if the resource group already exists with 'terraform_data' resource
resource "terraform_data" "rg_check" {
  input            = var.resource_group_name
  triggers_replace = timestamp()

  provisioner "local-exec" {
    # Use the Azure CLI to check if the resource group exists adn create if not
    command = <<EOT
      $ErrorActionPreference = "Stop"
      az login --service-principal --username $env:ARM_CLIENT_ID --password $env:ARM_CLIENT_SECRET --tenant $env:ARM_TENANT_ID --output none
      az account set --subscription $env:ARM_SUBSCRIPTION_ID --output none
      $rg_verify = az group show --name ${var.resource_group_name} --query id --output tsv
      if ($rg_verify) {
        $rg_exist = Write-Output "$rg_verify"
      } else {
        $rg_create = (az group create --name ${var.resource_group_name} --location ${var.location} --query id --output tsv)
      }
    EOT
  }
}

output "rg_id_output" {
  description = "The ID of the resource group that was created or already existed"
  value       = terraform_data.rg_existing.output
}

# # The verification test will return the resource ID regardless of whether the resource group was created or already existed
# import {
#   to = azurerm_resource_group.rg
#   id = module.verify.rg_id_output
# }

# # Resource Group block is required to import the resource group ID from the verify module
# resource "azurerm_resource_group" "rg" {
#   name     = "Demo-Inf-Dev-Rg-720"
#   location = "UKSouth"
# }

# # Create the storage account in the resource group
# resource "azurerm_storage_account" "sa" {
#   resource_group_name      = "Demo-Inf-Dev-Rg-720"
#   name                     = "demoinfdevsa720"
#   location                 = "UKSouth"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }


# #Create a Resource Group
# resource "azurerm_resource_group" "rg" {
#   name     = var.resource_group_name
#   location = var.location
#   tags     = var.tags
# }

# #Write a resource creation of a user assigned managed identity
# resource "azurerm_user_assigned_identity" "uai" {
#   name                = "${var.resource_group_name}-uai"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# #Create a Key Vault for the Resource Group
# resource "azurerm_key_vault" "kv" {
#   name                        = "${lower(var.key_vault_name)}${random_integer.kv_num.result}"
#   location                    = azurerm_resource_group.rg.location
#   resource_group_name         = azurerm_resource_group.rg.name
#   enable_rbac_authorization   = var.use_rbac_mode
#   enabled_for_disk_encryption = true
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = false
#   sku_name                    = "standard"
#   tags                        = var.tags
# }

# resource "random_integer" "kv_num" {
#   min = 0001
#   max = 9999
# }