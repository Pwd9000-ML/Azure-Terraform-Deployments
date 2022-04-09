tags = {
  terraformDeployment = "true",
  GithubRepo          = "https://github.com/Pwd9000-ML/Azure-Terraform-Deployments"
  Environment         = "DEV"
}

storage_config = [
  #V2 Storage - SiteA
  {
    name                      = "pwd9000v2sitea"
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    enable_https_traffic_only = true
    access_tier               = "Hot"
    is_hns_enabled            = false
    site_name                 = "siteA"
  },
  #ADLS2 Storage - SiteA
  {
    name                      = "pwd9000dfssitea"
    account_kind              = "BlockBlobStorage"
    account_tier              = "Premium"
    account_replication_type  = "ZRS"
    enable_https_traffic_only = true
    access_tier               = "Hot"
    is_hns_enabled            = true
    site_name                 = "siteA"
  },
  #V2 Storage - SiteB
  {
    name                      = "pwd9000v2siteb"
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    enable_https_traffic_only = false
    access_tier               = "Hot"
    is_hns_enabled            = false
    site_name                 = "siteB"
  }
]