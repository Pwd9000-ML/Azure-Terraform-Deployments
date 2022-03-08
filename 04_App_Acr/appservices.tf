resource "azurerm_resource_group" "RG" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "ASP" {
  name                = var.asp_name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  kind                = var.asp_kind
  reserved            = var.asp_kind == "linux" ? true : false

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_application_insights" "INSIGHTS" {
  name                = var.app_insights_name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  application_type    = "web"
  workspace_id        = var.workspace_id != null ? var.workspace_id : null
}

output "insights_key" {
  value     = azurerm_application_insights.INSIGHTS.instrumentation_key
  sensitive = true
}

resource "azurerm_app_service" "APPSVC" {
  name                = var.appsvc_name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  app_service_plan_id = azurerm_app_service_plan.ASP.id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    acr_use_managed_identity_credentials = true
    ftps_state                           = "FtpsOnly"
    linux_fx_version                     = var.asp_kind == "linux" ? local.linux_fx_version : null
  }

  app_settings = lookup(local.app_settings, "linux_app_settings", null)
  #app_settings = var.appsvc_settings
}