resource "azurerm_resource_group" "RG" {
  name     = "pwd9000-testing-rg"
  location = "uksouth"
}

resource "azurerm_storage_account" "SAS" {
  for_each = { for n in var.storage_config : n.name => n }

  #Implicit dependency from previous resource
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location

  #values from variable storage_config objects
  name                      = each.value.name
  account_kind              = each.value.account_kind
  account_tier              = each.value.account_tier
  account_replication_type  = each.value.account_replication_type
  access_tier               = each.value.access_tier
  enable_https_traffic_only = each.value.enable_https_traffic_only
  is_hns_enabled            = each.value.is_hns_enabled
}

data "azurerm_subnet" "data_subnet" {
  name                 = "default"
  virtual_network_name = "UKS-VNET"
  resource_group_name  = "Github-Assets"
}

resource "azurerm_private_endpoint" "SASPE" {
  for_each            = toset([for pe in var.storage_config : pe.name if pe.requires_private_endpoint == true])
  name                = "${each.value}-pe"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  subnet_id           = data.azurerm_subnet.data_subnet.id

  private_service_connection {
    name                           = "${each.value}-pe-sc"
    private_connection_resource_id = azurerm_storage_account.SAS[each.value].id
    is_manual_connection           = false
    subresource_names              = ["dfs"]
  }
}
