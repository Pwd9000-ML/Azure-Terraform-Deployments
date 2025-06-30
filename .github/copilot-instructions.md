---
applyTo: "**"
---
# Project general coding standards

Apply the [general coding guidelines](./general-coding.instructions.md) to all code.

## General Instructions for this Workspace:
- Always prioritise security best practices.
- Favour idempotent solutions.
- Use British English spelling.

## Naming Conventions
- Use terraform formatting for all Terraform files (like terraform fmt)
- Whenever `resource` or `data` blocks are generated, ensure they follow the naming convention of the provider e.g `resource "azurerm_storage_account" "meaningful_context_name"` or `data "azurerm_storage_account" "meaningful_context_name"`.
- Whenever `output` blocks are generated, ensure they follow the naming convention of the provider e.g `output "meaningful_context_name"`.
- Ensure that naming of resources complies to the [Azure Resource Naming Rules](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming). e.g., resource groups should be named `rg-<project>-<environment>-<region>-<type>-<3digitnumber>` (e.g., `rg-myapp-dev-uks-web-001`).
- Always use lowercase for resource names, and separate words with hyphens (e.g., `my-app-service`). use terraform functions like `lower()` when input is not guaranteed to be lowercase.

## Terraform Best Practices:
- When generating Terraform for Azure, always use the `azurerm` provider version `~>3.0`.
- Ensure all Terraform modules include a `variables.tf`, `outputs.tf`, and a `README.md`.
- **Private Networking First!** Wherever possible, prioritise the use of private endpoints for Azure PaaS services (e.g., Storage Accounts, Azure SQL Database, Key Vault, Container Registry) to ensure traffic stays within the virtual network.
- When suggesting virtual networks, always include at least one subnet dedicated for private endpoints and ensure `enforce_private_link_endpoint_network_policies = true` on any such subnets.
- Never hardcode secrets or sensitive values. Always reference them from Azure Key Vault, GitHub Secrets or Azure DevOps Secure Files.
- Prefer using `for_each` over `count` for deploying multiple similar resources over duplicating resource blocks.
- Avoid excessive use of `data` blocks and prefer using `locals` for static values by computed values based on the provider.
- Add comments to explain complex resources or unusual patterns.