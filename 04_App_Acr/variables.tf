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
    type = string
    default = null
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
  default = null
}

variable "linux_fx_version" {
    type = string
    default = null
    description = "Specifies linux version"
}

#ACR
variable "acr_name" {
  type        = string
  description = "Specifies the container registry name to be created."
}