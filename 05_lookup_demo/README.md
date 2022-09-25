<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.RGS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.SAS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [random_integer.sa_num](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_site_names"></a> [site\_names](#input\_site\_names) | Provide a list of all Contoso site names - Will be mapped to local var 'site\_configs' | `list(string)` | <pre>[<br>  "siteA",<br>  "siteB"<br>]</pre> | no |
| <a name="input_storage_config"></a> [storage\_config](#input\_storage\_config) | Provide a list of Storage Configs | <pre>list(object({<br>    name                      = string<br>    account_kind              = string<br>    account_tier              = string<br>    account_replication_type  = string<br>    access_tier               = string<br>    enable_https_traffic_only = bool<br>    is_hns_enabled            = bool<br>    site_name                 = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a map of tags to be applied to the resources created. | `map(any)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->