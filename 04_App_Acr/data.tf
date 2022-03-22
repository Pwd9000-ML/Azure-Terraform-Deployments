## Get subnet Ids to create NSGs for each subnet
data "azurerm_subnet" "network_subs" {
  count                = length(azurerm_virtual_network.VNET.subnets)
  name                 = azurerm_virtual_network.VNET.subnets[count.index]
  virtual_network_name = azurerm_virtual_network.VNET.name
  resource_group_name  = azurerm_resource_group.RG.name
  depends_on           = [azurerm_virtual_network.VNET, azurerm_subnet.SUBNETS]
}