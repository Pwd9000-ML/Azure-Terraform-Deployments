locals {
  site_configs = {
    siteA = {
      resource_group_name = "Demo-Inf-SiteA-RG"
      location            = "UKSouth"
      allowed_ips         = ["8.8.8.8", "8.8.8.9"]
    },
    siteB = {
      resource_group_name = "Demo-Inf-SiteB-RG"
      location            = "UKWest"
      allowed_ips         = ["7.7.7.7", "7.7.7.8"]
    }
  }
}