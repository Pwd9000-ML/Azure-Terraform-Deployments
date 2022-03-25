resource "azurerm_service_plan" "ASP" {
  name                = var.asp_name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  os_type             = var.asp_os_type
  sku_name            = var.asp_sku_name
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

resource "azurerm_linux_web_app" "APPSVC" {
  name                = var.appsvc_name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  service_plan_id     = azurerm_service_plan.ASP.id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    container_registry_use_managed_identity = true
    ftps_state                              = "FtpsOnly"
    application_stack {
      docker_image     = "${var.acr_name}.azurecr.io/${var.appsvc_name}"
      docker_image_tag = "latest"
    }
    vnet_route_all_enabled = var.vnet_route_all_enabled
  }

  app_settings = lookup(local.app_settings, "linux_app_settings", null)
  #app_settings = var.appsvc_settings
}

resource "azurerm_app_service_virtual_network_swift_connection" "azure_vnet_connection" {
  count          = var.vnet_integ_required == true ? 1 : 0
  app_service_id = azurerm_linux_web_app.APPSVC.id
  subnet_id      = azurerm_subnet.SUBNETS["App-Service-Integration-Subnet"].id
}