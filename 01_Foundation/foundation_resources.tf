### Data Sources ###
data "azurerm_client_config" "current" {}

##################################################
# FOUNDATIONAL RESOURCES                         #
##################################################

# Check if the resource group already exists with 'terraform_data' resource
resource "terraform_data" "rg_existing" {
  triggers_replace = timestamp()

  provisioner "local-exec" {
    # Use the Azure CLI to check if the resource group exists
    command = "az group show --name 'Demo-Inf-Dev-Rg-720' --query id"
  }
}

# Only create the resource group if it does not exist
resource "azurerm_resource_group" "rg" {
  count    = terraform_data.rg_existing.result == "" ? 1 : 0
  name     = "Demo-Inf-Dev-Rg-720"
  location = "UKSouth"
}

# Create the storage account in the resource group
resource "azurerm_storage_account" "sa" {
  resource_group_name      = "Demo-Inf-Dev-Rg-720"
  name                     = "demoinfdevsa720"
  location                 = "UKSouth"
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