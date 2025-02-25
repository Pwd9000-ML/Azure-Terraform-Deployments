# Declare variables to verify if RG exists
variable "resource_group_name" {
  description = "The name of the resource group to verify"
  type        = string
  default     = ""
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "UKSouth"
}

# Check if the resource group already exists with 'terraform_data' resource
resource "terraform_data" "rg_existing" {
  input            = var.resource_group_name
  triggers_replace = timestamp()

  provisioner "local-exec" {
    # Use the Azure CLI to check if the resource group exists adn create if not
    command = <<EOT
      $ErrorActionPreference = "Stop"
      az login --service-principal --username $env:ARM_CLIENT_ID --password $env:ARM_CLIENT_SECRET --tenant $env:ARM_TENANT_ID --output none
      az account set --subscription $env:ARM_SUBSCRIPTION_ID --output none
      $rg_verify = az group show --name ${var.resource_group_name} --query id --output tsv
      if ($rg_verify) {
        $rg_exist = Write-Output "$rg_verify"
      } else {
        $rg_create = az group create --name ${var.resource_group_name} --location ${var.location} --query id --output tsv 
      }
    EOT
  }
}

output "rg_id_output" {
  description = "The ID of the resource group that was created or already existed"
  value       = terraform_data.rg_existing.output
}