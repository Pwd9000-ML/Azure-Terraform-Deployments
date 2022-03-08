locals {
  #Appsvc Settings
  app_settings = {
    default_settings = sensitive({
      APPINSIGHTS_INSTRUMENTATIONKEY = "${azurerm_application_insights.INSIGHTS.instrumentation_key}"
      DOKCER_REGISTRY_SERVER_URL     = "${var.acr_name}.azurecr.io"
    }),
    linux_app_settings = sensitive({
      APPINSIGHTS_INSTRUMENTATIONKEY = "${azurerm_application_insights.INSIGHTS.instrumentation_key}"
      DOKCER_REGISTRY_SERVER_URL     = "${var.acr_name}.azurecr.io"
      WEBSITE_PULL_IMAGE_OVER_VNET   = "true"
      LINUX_SENSITIVE_VALUE          = "!!sensitive_value!!"
    })
  }
  linux_fx_version = "DOCKER|${var.acr_name}/${var.appsvc_name}:latest"
}