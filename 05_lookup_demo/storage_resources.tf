##################################################
# RESOURCES                                      #
##################################################
resource "azurerm_resource_group" "RGS" {
  for_each = toset(var.site_names)
  name     = lookup(local.site_configs[each.value], "resource_group_name", null)
  location = lookup(local.site_configs[each.value], "location", null)
}