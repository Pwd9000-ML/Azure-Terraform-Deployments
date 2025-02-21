### Data Sources ###
data "azurerm_client_config" "current" {}

##################################################
# FOUNDATIONAL RESOURCES                         #
##################################################

# Check if the resource group already exists with 'data' resource
data "azurerm_resource_group" "rg" {
  name = "Demo-Inf-Dev-Rg-720"
}

# Only create the resource group if it does not exist in the data resource check
resource "azurerm_resource_group" "rg" {
  for_each = data.azurerm_resource_group.rg == null ? toset(["Demo-Inf-Dev-Rg-720"]) : toset([])
  name     = each.key
  location = "East US"
}

# Create other resources that depend on the resource group 
resource "azurerm_storage_account" "sa" {
  name                     = "demoinfdevsa720"
  resource_group_name      = azurerm_resource_group.rg["Demo-Inf-Dev-Rg-720"].name
  location                 = azurerm_resource_group.rg["Demo-Inf-Dev-Rg-720"].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
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