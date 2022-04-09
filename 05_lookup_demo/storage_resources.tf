##################################################
# RESOURCES                                      #
##################################################
resource "azurerm_resource_group" "RGS" {
  for_each = toset(var.site_names)
  name     = lookup(local.site_configs[each.value], "resource_group_name", null)
  location = lookup(local.site_configs[each.value], "location", null)
}

resource "azurerm_storage_account" "SAS" {
  for_each = { for n in var.storage_config : n.name => n }

  #Implicit dependency from previous resource
  resource_group_name = azurerm_resource_group.RGS[each.value.site_name].name
  location            = azurerm_resource_group.RGS[each.value.site_name].location

  #values from variable storage_config objects
  name                      = "${lower(each.value.name)}${random_integer.sa_num.result}"
  account_kind              = each.value.account_kind
  account_tier              = each.value.account_tier
  account_replication_type  = each.value.account_replication_type
  access_tier               = each.value.access_tier
  enable_https_traffic_only = each.value.enable_https_traffic_only
  is_hns_enabled            = each.value.is_hns_enabled

  #Lookup allowed ips
  network_rules {
    default_action = "Deny"
    ip_rules       = lookup(local.site_configs[each.value.site_name], "allowed_ips", null)
  }
}

resource "random_integer" "sa_num" {
  min = 0001
  max = 9999
}