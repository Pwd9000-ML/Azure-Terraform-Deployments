# Declare variables to verify if RG exists
variable "resource_group_name" {
  description = "The name of the resource group to verify"
  type        = string
  default     = ""
}

# Check if the resource group already exists with 'terraform_data' resource
resource "terraform_data" "rg_existing" {
  input            = var.resource_group_name
  triggers_replace = timestamp()

  provisioner "local-exec" {
    # Use the Azure CLI to check if the resource group exists
    command = <<EOT
      $ErrorActionPreference = "Stop"
      az login --service-principal --username $env:ARM_CLIENT_ID --password $env:ARM_CLIENT_SECRET --tenant $env:ARM_TENANT_ID --output none
      az account set --subscription $env:ARM_SUBSCRIPTION_ID --output none
      $rg = az group show --name ${var.resource_group_name} --query name --output tsv
      if ($rg) {
        Write-Output "true"
      } else {
        Write-Output "false"
      }
    EOT
  }
}

output "rg_exists" {
  description = "Indicates if the resource group exists"
  value       = terraform_data.rg_existing.output
}