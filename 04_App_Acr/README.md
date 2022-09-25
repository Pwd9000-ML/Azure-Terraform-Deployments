<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_virtual_network_swift_connection.azure_vnet_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_application_insights.INSIGHTS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_container_registry.ACR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_linux_web_app.APPSVC](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_network_security_group.NSG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_resource_group.RG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.role_assigment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.ASP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_subnet.SUBNETS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.nsg_subnet_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.VNET](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_admin_enabled"></a> [acr\_admin\_enabled](#input\_acr\_admin\_enabled) | Specifies whether the ACR admin account should be enabled or not. | `bool` | `false` | no |
| <a name="input_acr_custom_fw_rules"></a> [acr\_custom\_fw\_rules](#input\_acr\_custom\_fw\_rules) | Specifies a list of custom IPs or CIDR ranges to whitelist on the ACR. | `list(string)` | `null` | no |
| <a name="input_acr_georeplications_configuration"></a> [acr\_georeplications\_configuration](#input\_acr\_georeplications\_configuration) | n/a | <pre>list(object({<br>    location                = string<br>    zone_redundancy_enabled = bool<br>  }))</pre> | `[]` | no |
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Specifies the container registry name to be created. | `string` | n/a | yes |
| <a name="input_acr_network_rule_set_default_action"></a> [acr\_network\_rule\_set\_default\_action](#input\_acr\_network\_rule\_set\_default\_action) | Specifies the default network rule set action. | `string` | `"Deny"` | no |
| <a name="input_acr_requires_identity"></a> [acr\_requires\_identity](#input\_acr\_requires\_identity) | Specifies whether the ACR requires a system assigned managed identity. | `bool` | `true` | no |
| <a name="input_acr_sku"></a> [acr\_sku](#input\_acr\_sku) | Specifies the ACR SKU. | `string` | `"Standard"` | no |
| <a name="input_app_insights_name"></a> [app\_insights\_name](#input\_app\_insights\_name) | Specifies the app insights name to be created. | `string` | n/a | yes |
| <a name="input_appsvc_name"></a> [appsvc\_name](#input\_appsvc\_name) | Specifies the app service name to be created. | `string` | n/a | yes |
| <a name="input_appsvc_settings"></a> [appsvc\_settings](#input\_appsvc\_settings) | Specifies the app service settings to be created. | `map(any)` | `null` | no |
| <a name="input_asp_name"></a> [asp\_name](#input\_asp\_name) | Specifies the name of the App service plan that will be created. | `string` | n/a | yes |
| <a name="input_asp_os_type"></a> [asp\_os\_type](#input\_asp\_os\_type) | (Optional) The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `WindowsContainer` | `string` | `"Linux"` | no |
| <a name="input_asp_sku_name"></a> [asp\_sku\_name](#input\_asp\_sku\_name) | (Optional) The SKU for the plan. Possible values include `B1`, `B2`, `B3`, `D1`, `F1`, `FREE`, `I1`, `I2`, `I3`, `I1v2`, `I2v2`, `I3v2`, `P1v2`, `P2v2`, `P3v2`, `P1v3`, `P2v3`, `P3v3`, `S1`, `S2`, `S3`, `SHARED`, `EP1`, `EP2`, `EP3`, `WS1`, `WS2`, and `WS3`. | `string` | `"S1"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where Azure resource will be created. | `string` | `"uksouth"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the resource group that will be created. | `string` | n/a | yes |
| <a name="input_subnets_delegated"></a> [subnets\_delegated](#input\_subnets\_delegated) | Specifies a list of delegated subnet objects (if any are required) of the virtual network that will be created. | `list` | `[]` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Specifies the address space of the virtual network that will be created. | `list(string)` | n/a | yes |
| <a name="input_vnet_integ_required"></a> [vnet\_integ\_required](#input\_vnet\_integ\_required) | Specifies if VNET integration is required or not. | `bool` | `false` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Specifies the name of the virtual network that will be created. | `string` | n/a | yes |
| <a name="input_vnet_route_all_enabled"></a> [vnet\_route\_all\_enabled](#input\_vnet\_route\_all\_enabled) | Specifies if VNET route all is enabled or not. | `bool` | `false` | no |
| <a name="input_vnet_subnets"></a> [vnet\_subnets](#input\_vnet\_subnets) | Specifies a list of subnet objects of the virtual network that will be created. | <pre>list(object({<br>    name           = string<br>    address_prefix = string<br>  }))</pre> | `[]` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | Speciy the log analytics workspace ID, if present (If left as null, uses legacy mode) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_insights_key"></a> [insights\_key](#output\_insights\_key) | n/a |
<!-- END_TF_DOCS -->