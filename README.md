# Azure-Terraform-Deployments

Repo used to deploy Azure Resources using Terraform and GitHub Actions.

This repo showcases how to use github actions to build up infrastructure in Azure using a non-monolithic approach and re-usable github action workflows to construct and simplify complex terraform deployments into simpler manageable tasks and workflows.

Each workflow can be independently deployed e.g.

- By running workflow `01_Foundation` first, will create a foundational deployment `PLAN` of an Azure Resource Group, key vault and log analytics workspace. The plan is loaded into the workflow artifacts and if validated successfully it will trigger the `tf_apply` re-usable workflow to trigger the deployment.

- Next `02_Storage` can be triggered independently and will also use a separate state file and follow the same process of a `PLAN` followed by validation, followed by deployment.

- `03 etc` then be run. etc etc
