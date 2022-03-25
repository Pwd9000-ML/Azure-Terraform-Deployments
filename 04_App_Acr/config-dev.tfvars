#RG
resource_group_name = "Demo-Inf-Dev-Rg"
location            = "UKSouth"

#VNET
vnet_name          = "Demo-Inf-Dev-Vnet"
vnet_address_space = ["10.2.0.0/16"]
subnets_delegated = [
  {
    subnet_name              = "Subnet0"
    subnet_address_prefixes  = ["10.2.0.0/24"]
    subnet_service_endpoints = []
    delegation               = []
  },
  {
    subnet_name              = "Subnet1"
    subnet_address_prefixes  = ["10.2.1.0/24"]
    subnet_service_endpoints = []
    delegation               = []
  },
  {
    subnet_name              = "App-Service-Integration-Subnet"
    subnet_address_prefixes  = ["10.2.2.0/27"]
    subnet_service_endpoints = ["Microsoft.ContainerRegistry"]
    delegation = [
      {
        delegation_name = "delegated-appservice"
        service = [
          {
            service_name = "Microsoft.Web/serverFarms"
            service_actions = [
              "Microsoft.Network/virtualNetworks/subnets/action",
              "Microsoft.Network/virtualNetworks/subnets/join/action",
              "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
              "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
            ]
          }
        ]
      }
    ]
  }
]

#ASP
asp_name = "demo-inf-dev-asp"

#INSIGHTS
app_insights_name = "demo-inf-dev-insights"

#APPSVC
appsvc_name = "demo-inf-dev-linux-appsvc"
appsvc_settings = {
  APPINSIGHTS_INSTRUMENTATIONKEY = "!!sensitive_Key!!"
  sensitive_key1                 = "P@ssw0rd01"
  sensitive_key2                 = "P@ssw0rd02"
}
vnet_route_all_enabled = true
vnet_integ_required    = true

#ACR
acr_name            = "demoinfdevacr"
acr_sku             = "Premium"
acr_custom_fw_rules = ["183.44.33.0/24", "8.8.8.8"]