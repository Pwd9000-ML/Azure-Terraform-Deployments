# General Terraform Coding Standards

## Code Structure and Organisation
- Always use consistent directory structure with separate environments (dev, uat, prod)
- Create dedicated modules for reusable infrastructure components
- Keep resource definitions in separate files by logical grouping (e.g., `network.tf`, `storage.tf`, `compute.tf`)
- Include `variables.tf`, `outputs.tf`, and `README.md` in every module
- Use meaningful file names that reflect their purpose

## Naming Conventions
- Use lowercase for all resource names and separate words with hyphens (e.g., `my-storage-account`)
- Follow Azure Resource Naming Rules and conventions (e.g., `rg-<project>-<environment>-<region>-<type>-<3digitnumber>`)
- Apply consistent naming patterns across all resources within a project
- Use descriptive resource names that indicate purpose and environment
- Implement naming using `locals` block for consistency across resources

## Resource Management
- Use `for_each` instead of `count` for creating multiple similar resources
- Prefer `for_each` over duplicating resource blocks
- Implement resource dependencies explicitly using `depends_on` when implicit dependencies aren't sufficient
- Group related resources logically within the same configuration file
- Use data sources to reference existing resources rather than hardcoding values

## Variables and Configuration
- Define all variables in `variables.tf` with proper descriptions and types
- Use appropriate variable types (`string`, `number`, `bool`, `list`, `map`, `object`)
- Set sensible default values where appropriate
- Validate input variables using validation blocks
- Use separate `.tfvars` files for different environments
- Never hardcode sensitive values - use Azure Key Vault, environment variables, or Terraform Cloud

## State Management
- Always use remote state backend (Azure Storage Account with state locking)
- Enable state locking to prevent concurrent modifications
- Use separate state files for different environments
- Implement proper state file encryption
- Never commit state files to version control
- Use workspace separation for environment isolation

## Security Best Practices
- Never store secrets or sensitive data in plain text
- Use Azure Key Vault for secret management
- Reference secrets from Key Vault using data sources
- Enable private endpoints for Azure PaaS services wherever possible
- Implement network security groups and proper access controls
- Use managed identities for authentication when possible
- Apply principle of least privilege for all resource access

## Code Quality and Documentation
- Use consistent formatting with `terraform fmt`
- Validate configuration with `terraform validate`
- Add meaningful comments for complex logic or business requirements
- Document module usage, inputs, and outputs in `README.md`
- Use descriptive commit messages following conventional commit standards
- Implement pre-commit hooks for formatting and validation

## Networking Best Practices
- Design virtual networks with proper CIDR planning
- Create dedicated subnets for different tiers (web, app, data)
- Include dedicated subnet for private endpoints with `enforce_private_link_endpoint_network_policies = true`
- Implement network segmentation using Network Security Groups
- Use private endpoints for Azure PaaS services to keep traffic within VNet
- Plan for future growth when designing address spaces

## Performance and Optimisation
- Use locals for computed values and reduce repetition
- Minimise the use of data sources by caching values in locals
- Implement conditional resource creation using `count` or `for_each` with conditions
- Use resource targeting for faster deployments during development
- Implement parallel resource creation where dependencies allow

## Testing and Validation
- Use `terraform validate` and `terraform fmt -check`
- Perform security scanning using tools like tfsec


## Version Control and CI/CD
- Use semantic versioning for modules
- Tag releases appropriately for module versions
- Implement GitOps workflow with proper branch protection
- Use pull requests for all infrastructure changes
- Implement automated testing in CI/CD pipelines
- Store provider version constraints in configuration

## Provider and Version Management
- Pin provider versions using `required_providers` block
- Use version constraints (e.g., `~> 3.0`) for minor version flexibility
- Keep providers up to date but test thoroughly before upgrading
- Document breaking changes when upgrading provider versions into a `CHANGELOG.md` file
- Use consistent provider versions across all modules

## Environment Management
- Use separate configurations for each environment
- Implement consistent variable naming across environments
- Use workspace separation or separate state files for environments
- Validate environment-specific configurations
- Document environment-specific requirements and constraints