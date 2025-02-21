### Data Sources ###
data "azurerm_client_config" "current" {}

##################################################
# FOUNDATIONAL RESOURCES                         #
##################################################

# Check if the resource group already exists with 'data' resource
data "azurerm_resource_group" "rg" {
  name = "Demo-Inf-Dev-Rg-720"

  lifecycle {
    postcondition {
      condition     = can(self.id) # Ensure Terraform does not fail if it cannot find the RG
      error_message = "Resource Group not found. Terraform will proceed to create it."
    }
  }
}

# Determine whether to create the resource group using terraform or use the existing resource group ID if it exists
locals {
  create_rg = length(try(data.azurerm_resource_group.rg.id, "")) == 0 ? toset(["Demo-Inf-Dev-Rg-720"]) : toset([])
}

# Only create the resource group if it does not exist otherwise use the existing resource group ID
resource "azurerm_resource_group" "rg" {
  for_each = local.create_rg
  name     = each.key
  location = "East US"
}

# Create storage account and reference the correct RG
resource "azurerm_storage_account" "sa" {
  name                     = "demoinfdevsa720"
  resource_group_name      = coalesce(try(data.azurerm_resource_group.rg.name, null), try(azurerm_resource_group.rg["Demo-Inf-Dev-Rg-720"].name, null))
  location                 = coalesce(try(data.azurerm_resource_group.rg.location, null), try(azurerm_resource_group.rg["Demo-Inf-Dev-Rg-720"].location, null))
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Explicit dependency to ensure RG exists before SA is created
  depends_on = [azurerm_resource_group.rg]
}


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