### Data Sources ###
data "azurerm_client_config" "current" {}

##################################################
# FOUNDATIONAL RESOURCES                         #
##################################################

# Check if the resource group already exists
data "azurerm_resource_group" "rg_existing" {
  name = "Demo-Inf-Dev-Rg-720"
}

# Determine whether the resource group exists
locals {
  rg_exists = can(data.azurerm_resource_group.rg_existing.id) # Returns true if RG exists
}

# Only create the resource group if it does not exist
resource "azurerm_resource_group" "rg" {
  count    = local.rg_exists ? 0 : 1
  name     = "Demo-Inf-Dev-Rg-720"
  location = "East US"
}

# Create the storage account and reference the correct RG
resource "azurerm_storage_account" "sa" {
  name = "demoinfdevsa720"

  # Use existing RG from data source if available, otherwise use the newly created RG
  resource_group_name = local.rg_exists ? data.azurerm_resource_group.rg_existing.name : azurerm_resource_group.rg[0].name
  location            = local.rg_exists ? data.azurerm_resource_group.rg_existing.location : azurerm_resource_group.rg[0].location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Ensure Terraform waits for RG creation if needed
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