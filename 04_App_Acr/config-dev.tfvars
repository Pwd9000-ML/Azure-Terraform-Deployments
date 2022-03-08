#RG
resource_group_name = "Demo-Inf-Dev-Rg"
location            = "UKSouth"

#ASP
asp_name = "demo-inf-dev-asp"
asp_kind = "linux"

#INSIGHTS
app_insights_name = "demo-inf-dev-insights"

#APPSVC
appsvc_name = "demo-inf-dev-linux-appsvc"
appsvc_settings = {
  APPINSIGHTS_INSTRUMENTATIONKEY = "!!sensitive_Key!!"
  sensitive_key1                 = "P@ssw0rd01"
  sensitive_key2                 = "P@ssw0rd02"
}

#ACR
acr_name = "demoinfdevacr"