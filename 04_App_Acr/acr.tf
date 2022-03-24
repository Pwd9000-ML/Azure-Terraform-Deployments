resource "azurerm_container_registry" "ACR" {
  name                = var.acr_name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled

  dynamic "identity" {
    for_each = var.acr_requires_identity == true ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  dynamic "georeplications" {
    for_each = var.acr_sku == "Premium" ? var.acr_georeplications_configuration : []
    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zone_redundancy_enabled
    }
  }

  dynamic "network_rule_set" {
    for_each = local.acr_fw_rules != null ? local.acr_fw_rules : []
    content {
      default_action = network_rule_set.value.default_action
      dynamic "ip_rule" {
        for_each = network_rule_set.value["ip_rules"] != [] ? network_rule_set.value["ip_rules"] : []
        content {
          action   = ip_rule.value["action"]
          ip_range = ip_rule.value["ip_range"]
        }
      }

      dynamic "virtual_network" {
        for_each = network_rule_set.value["virtual_network_subnets"] != [] ? network_rule_set.value["virtual_network_subnets"] : []
        content {
          action    = virtual_network.value["action"]
          subnet_id = virtual_network.value["subnet_id"]
        }
      }
    }
  }
  
  depends_on = [azurerm_app_service_virtual_network_swift_connection.azure_vnet_connection]
}

## Give App service Identity ACRPull access
resource "azurerm_role_assignment" "role_assigment" {
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.ACR.id
  principal_id         = azurerm_app_service.APPSVC.identity.0.principal_id
}