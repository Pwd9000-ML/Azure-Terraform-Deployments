variable "site_names" {
  type        = list(string)
  default     = ["siteA", "siteB"]
  description = "Provide a list of all Contoso site names - Will be mapped to local var 'site_configs'"
}

variable "storage_config" {
  type = list(object({
    name                      = string
    account_kind              = string
    account_tier              = string
    account_replication_type  = string
    access_tier               = string
    enable_https_traffic_only = bool
    is_hns_enabled            = bool
    site_name                 = string
  }))
  default     = []
  description = "Provide a list of Storage Configs"
}

variable "tags" {
  type        = map(any)
  description = "Specifies a map of tags to be applied to the resources created."
}
