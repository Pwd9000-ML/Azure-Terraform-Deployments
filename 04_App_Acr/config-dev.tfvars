#RG
resource_group_name = "Demo-Inf-Dev-Rg"
location            = "UKSouth"

#VNET
vnet_name          = "Demo-Inf-Dev-Vnet"
vnet_address_space = ["10.2.0.0/16"]
vnet_subnets = [
  {
    address_prefix = "10.2.0.0/24"
    name           = "Subnet1"
  },
  {
    address_prefix = "10.2.1.0/24"
    name           = "Subnet2"
  }
]

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