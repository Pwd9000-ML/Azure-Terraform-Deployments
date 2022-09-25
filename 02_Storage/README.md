<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.15.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.15.1 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.sas](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [random_integer.sa_num](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location/region where Azure resource will be created. | `string` | `"uksouth"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the resource group that will be created. | `string` | n/a | yes |
| <a name="input_storage_config"></a> [storage\_config](#input\_storage\_config) | n/a | <pre>list(object({<br>    name                      = string<br>    account_kind              = string<br>    account_tier              = string<br>    account_replication_type  = string<br>    access_tier               = string<br>    enable_https_traffic_only = bool<br>    min_tls_version           = string<br>    is_hns_enabled            = bool<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a map of tags to be applied to the resources created. | `map(any)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->