#RG
variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the resource group that will be created."
}

variable "location" {
  type        = string
  description = "The location/region where Azure resource will be created."
  default     = "uksouth"
}

#VNET
variable "vnet_name" {
  type        = string
  description = "Specifies the name of the virtual network that will be created."
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Specifies the address space of the virtual network that will be created."
}

variable "vnet_subnets" {
  type = list(object({
    name           = string
    address_prefix = string
  }))
  description = "Specifies a list of subnet objects of the virtual network that will be created."
  default     = []
}

variable "subnets_delegated" {
  description = "Specifies a list of delegated subnet objects (if any are required) of the virtual network that will be created."
  default     = []
}

#ASP
variable "asp_name" {
  type        = string
  description = "Specifies the name of the App service plan that will be created."
}

variable "asp_os_type" {
  type        = string
  description = "(Optional) The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `WindowsContainer`"
  default     = "Linux"
}

variable "asp_sku_name" {
  type        = string
  description = "(Optional) The SKU for the plan. Possible values include `B1`, `B2`, `B3`, `D1`, `F1`, `FREE`, `I1`, `I2`, `I3`, `I1v2`, `I2v2`, `I3v2`, `P1v2`, `P2v2`, `P3v2`, `P1v3`, `P2v3`, `P3v3`, `S1`, `S2`, `S3`, `SHARED`, `EP1`, `EP2`, `EP3`, `WS1`, `WS2`, and `WS3`."
  default     = "S1"
}

#INSIGHTS
variable "app_insights_name" {
  type        = string
  description = "Specifies the app insights name to be created."
}

variable "workspace_id" {
  type        = string
  default     = null
  description = "Speciy the log analytics workspace ID, if present (If left as null, uses legacy mode)"
}

#APPSVC
variable "appsvc_name" {
  type        = string
  description = "Specifies the app service name to be created."
}

variable "appsvc_settings" {
  type        = map(any)
  description = "Specifies the app service settings to be created."
  default     = null
  sensitive   = true
}

variable "vnet_route_all_enabled" {
  type        = bool
  description = "Specifies if VNET route all is enabled or not."
  default     = false
}

variable "vnet_integ_required" {
  type        = bool
  description = "Specifies if VNET integration is required or not."
  default     = false
}

#ACR
variable "acr_name" {
  type        = string
  description = "Specifies the container registry name to be created."
}

variable "acr_admin_enabled" {
  type        = bool
  description = "Specifies whether the ACR admin account should be enabled or not."
  default     = false
}

variable "acr_sku" {
  type        = string
  description = "Specifies the ACR SKU."
  default     = "Standard"
}

variable "acr_requires_identity" {
  type        = bool
  description = "Specifies whether the ACR requires a system assigned managed identity."
  default     = true
}

variable "acr_georeplications_configuration" {
  type = list(object({
    location                = string
    zone_redundancy_enabled = bool
  }))
  default = []
}

variable "acr_custom_fw_rules" {
  type        = list(string)
  description = "Specifies a list of custom IPs or CIDR ranges to whitelist on the ACR."
  default     = null
}

variable "acr_network_rule_set_default_action" {
  type        = string
  description = "Specifies the default network rule set action."
  default     = "Deny"
}