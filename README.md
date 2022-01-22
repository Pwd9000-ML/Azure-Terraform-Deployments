# Azure-Terraform-Deployments

This repository is used to deploy Azure Resources using Terraform and GitHub Reusable Workflows.
Showcases how to use GitHub reusable workflows and GitHub environments to build enterprise scale multi environment infrastructure deployments in Azure using a non-monolithic approach, to construct and simplify complex terraform deployments into simpler manageable workteams and reducing duplicate deployment workflows by utilizing reusable GitHub workflows.

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/Azure-Terraform-Deployments/master/assets/main.png)

In this demo repository, each `caller` workflow is numbered and can be independently deployed e.g.

**01_Foundation:**

- The `caller` workflow `01_Foundation` will first call and trigger the reusable workflow `az_tf_plan` and create a foundational terraform deployment `PLAN` of an Azure Resource Group and key vault. The plan artifacts are compressed and loaded into the workflow artifacts and if validated successfully the caller workflow `01_Foundation` will then call and trigger the second reusable workflow `az_tf_apply` that will download and decompress the `PLAN` artifact and trigger the deployment. (Also demonstrated is how to use GitHub Environments to do multi staged environment based deployments with approvals - Optional)

**02_Storage:**

- Next the second `caller` workflow `02_Storage` can be used and triggered independently to expand on the first deployment in a separate state file to deploy some additional resources, building up the resource inventory in a non-monolithic way. In the case of this demo repository `02_Storage` will call the same reusable workflows used in the first `caller` workflow to create a terraform deployment `PLAN` of one General-V2 and one Data Lake Storage storage account. The plan artifacts are again compressed and loaded into the workflow artifacts and if validated successfully the caller workflow `02_Storage` will then call and trigger the second reusable workflow `az_tf_apply` that will download and decompress the `PLAN` artifact and trigger the deployment.

**03_etc_etc:**

- The same process can be repeated to create more terraform root modules to deploy even more resources etc etc...
