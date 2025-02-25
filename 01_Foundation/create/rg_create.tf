# Declare variables to verify if RG exists
variable "resource_group_name" {
  description = "The name of the resource group to verify"
  type        = string
  default     = ""
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = ""
}

# Only create the resource group if verify module output returns != var.resource_group_name
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}