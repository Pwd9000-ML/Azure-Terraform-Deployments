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

  network_rule_set = [
    {
      default_action = var.acr_network_rule_set_default_action
      ip_rule = [for each in local.acr_ip_rules :
        {
          action   = each["action"]
          ip_range = each["ip_range"]
        }
      ]
      virtual_network = [for each in local.acr_virtual_network_subnets :
        {
          action    = each["action"]
          subnet_id = each["subnet_id"]
        }
      ]
    }
  ]

}

## Give App service Identity ACRPull access
resource "azurerm_role_assignment" "role_assigment" {
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.ACR.id
  principal_id         = azurerm_linux_web_app.APPSVC.identity.0.principal_id
}