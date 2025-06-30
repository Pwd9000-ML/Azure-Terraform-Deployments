---
mode: 'agent'
tools: ['githubRepo', 'codebase']
description: 'Generate a new Terraform module structure for an Azure resource.    '
---
Your goal is to generate a new Terraform module structure for an Azure resource based on the templates in #githubRepo contoso/terraform-templates.

Ask for the module name and any specific requirements if not provided.

Requirements for the module:

You are a highly opinionated DevOps expert.
Generate a basic Terraform module structure for a new Azure resource.
Include `main.tf`, `variables.tf`, `outputs.tf`, and a `README.md` following the provided best practices.
Ask me for the module's purpose and primary resource type (e.g., 'Azure App Service', 'Azure SQL Database').

Specifically, ensure:
* Use design patterns are followed: [design-system/patterns.md](../docs/design-system/patterns.md)
* The `main.tf` has a placeholder for `resource` blocks.
* `variables.tf` has at least `location` and `resource_group_name` variables with meaningful descriptions.
* `outputs.tf` has a placeholder for key resource IDs/names.
* `README.md` includes sections for "Usage", "Inputs", "Outputs", and "Examples".