# Azure-Terraform-Deployments

Repo used to deploy Azure Resources using Terraform and GitHub Actions.

This repository showcases how to use GitHub reusable workflows and GitHub environments to build infrastructure in Azure using a non-monolithic approach, to construct and simplify complex terraform deployments into simpler manageable tasks and workflows.

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/Azure-Terraform-Deployments/master/assets/main.png)

Each workflow can be independently deployed e.g.

- The caller workflow `01_Foundation` will first call and trigger the reusable workflow `az_tf_plan` and create a foundational terraform deployment `PLAN` of an Azure Resource Group and key vault. The plan is loaded into the workflow artifacts and if validated successfully the caller workflow `01_Foundation` will call and trigger the second reusable workflow `az_tf_apply` that will download the `PLAN` artifact and trigger the deployment. (Also demonstrated is how to use GitHub Environments to do multi stages environment based deployments - Optional)

- Next the second caller workflow `02_Storage` can be used and triggered independently to expand teh deployment in a separate state to deploy some more resources, building up the resurce inventory, in the case of the example one General-V2 and one Data Lake Storage storage account will be created, again using the same two reusable workflows as what was used in the first caller workflow, and follow the same process of a `PLAN` followed by deployment.

- `03 etc` then be run. etc etc
