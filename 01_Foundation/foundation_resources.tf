### Data Sources ###
data "azurerm_client_config" "current" {}

##################################################
# FOUNDATIONAL RESOURCES                         #
##################################################

#Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

#Write a resource creation of a user assigned managed identity
resource "azurerm_user_assigned_identity" "uai" {
  name                = "${var.resource_group_name}-uai"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a list of the existing role assignment IDs to import using local variables
locals {
  role_assignments = {
    Contributor = "/subscriptions/829efd7e-aa80-4c0d-9c1c-7aa2557f8e07/resourceGroups/Demo-Inf-Dev-Rg/providers/Microsoft.Authorization/roleAssignments/1a533459-6925-4770-9c4e-0d341ae69691",
    Reader      = "/subscriptions/829efd7e-aa80-4c0d-9c1c-7aa2557f8e07/resourceGroups/Demo-Inf-Dev-Rg/providers/Microsoft.Authorization/roleAssignments/38e0ac0b-8342-40d9-ba29-7bfc16de6352"
  }
}

# Use the import block to declare the existing role assignments to import
import {
  for_each = local.role_assignments
  to       = azurerm_role_assignment.rbac[each.key]
  id       = each.value
}

# Create the azurerm_role_assignment resource importing the existing role assignments
resource "azurerm_role_assignment" "rbac" {
  for_each             = local.role_assignments
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
  role_definition_name = each.key
  scope                = azurerm_resource_group.rg.id
  #import {
  #  id = each.value
  #}
}


# # Create a null resource with a local-exec provisioner to create the role assignment for contributor and reader from a var.permissions list
# resource "null_resource" "rbac" {
#   for_each = toset(["Contributor", "Reader"])
#   triggers = {
#     always_run = timestamp()
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#       az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID --output none
#       az account set --subscription $ARM_SUBSCRIPTION_ID --output none
#       az role assignment create --assignee ${azurerm_user_assigned_identity.uai.principal_id} --role ${each.key} --scope ${azurerm_resource_group.rg.id}
#     EOT
#   }
# }

#Create a Key Vault for the Resource Group
resource "azurerm_key_vault" "kv" {
  name                        = "${lower(var.key_vault_name)}${random_integer.kv_num.result}"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enable_rbac_authorization   = var.use_rbac_mode
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  tags                        = var.tags
}

resource "random_integer" "kv_num" {
  min = 0001
  max = 9999
}