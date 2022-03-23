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

variable "asp_kind" {
  type        = string
  description = "Specifies the kind of App service plan that will be created."
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