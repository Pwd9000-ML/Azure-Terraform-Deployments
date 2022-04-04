## variables ##

variable "storage_config" {
  type = list(object({
    name                      = string
    account_kind              = string
    account_tier              = string
    account_replication_type  = string
    access_tier               = string
    enable_https_traffic_only = bool
    is_hns_enabled            = bool
    requires_private_endpoint = bool
  }))
  default = [
    #V2 Storage (hot) without private endpoint
    {
      name                      = "pwd9000v2sa001"
      account_kind              = "StorageV2"
      account_tier              = "Standard"
      account_replication_type  = "LRS"
      enable_https_traffic_only = true
      access_tier               = "Hot"
      is_hns_enabled            = false
      requires_private_endpoint = false
    },
    #V2 Storage (cool) without private endpoint
    {
      name                      = "pwd9000v2sa002"
      account_kind              = "StorageV2"
      account_tier              = "Standard"
      account_replication_type  = "LRS"
      enable_https_traffic_only = true
      access_tier               = "Cool"
      is_hns_enabled            = false
      requires_private_endpoint = false
    },
    #ADLS2 Storage with private endpoint
    {
      name                      = "pwd9000adls2sa001"
      account_kind              = "BlockBlobStorage"
      account_tier              = "Premium"
      account_replication_type  = "ZRS"
      enable_https_traffic_only = false
      access_tier               = "Hot"
      is_hns_enabled            = true
      requires_private_endpoint = true
    },
    #ADLS2 Storage without private endpoint
    {
      name                      = "pwd9000adls2sa002"
      account_kind              = "BlockBlobStorage"
      account_tier              = "Premium"
      account_replication_type  = "ZRS"
      enable_https_traffic_only = false
      access_tier               = "Hot"
      is_hns_enabled            = true
      requires_private_endpoint = false
    }
  ]
}