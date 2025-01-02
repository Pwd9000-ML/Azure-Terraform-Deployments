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

# Create a null resource with a local-exec provisioner to create the role assignment for contributor and reader from a var.permissions list
resource "null_resource" "rbac" {
  for_each = toset(["Contributor", "Reader"])
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOT
      az role assignment create --assignee ${azurerm_user_assigned_identity.uai.principal_id} --role ${each.key} --scope ${azurerm_resource_group.rg.id}
    EOT
  }
}

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