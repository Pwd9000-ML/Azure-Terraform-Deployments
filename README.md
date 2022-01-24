# Azure-Terraform-Deployments

Template repository - Use to deploy Azure Resources using Terraform and GitHub Reusable Workflows.  

See my [very detailed tutorial](https://dev.to/pwd9000/multi-environment-azure-deployments-with-terraform-and-github-2450) for in depth detail.

This repository can be reused by anyone to:  

- Learn about GitHub reusable workflows.
- Learn about terraform deployments in AZURE.
- Learn about multi-stage deployments and approvals in GitHub.
- Utilize in your own organization to build AZURE Infrastructure at scale.

Showcasing how to use GitHub reusable workflows and GitHub environments to build enterprise scale multi environment infrastructure deployments in Azure using a non-monolithic approach, to construct and simplify complex terraform deployments into simpler manageable work streams and reduce duplicate workflow code by utilizing reusable GitHub workflows.

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/Azure-Terraform-Deployments/master/assets/main.png)

In this demo repository, each `caller` workflow is numbered and can be independently deployed e.g.

**01_Foundation:**

- The first `caller` workflow `01_Foundation` will call and trigger a reusable workflow `az_tf_plan` and create a foundational terraform deployment `PLAN` based on the repository `path: ./01_Foundation` containing the terraform ROOT module/configuration of an Azure Resource Group and key vault. The plan artifacts are validated, compressed and uploaded into the workflow artifacts, the caller workflow `01_Foundation` will then call and trigger the second reusable workflow `az_tf_apply` that will download and decompress the `PLAN` artifact and trigger the deployment based on the plan. (Also demonstrated is how to use GitHub Environments to do multi staged environment based deployments with approvals - Optional)

**02_Storage:**

- Next the second `caller` workflow `02_Storage` can be used and triggered independently to expand on the first deployment in a separate state file to deploy some additional resources, building up the resource inventory in a non-monolithic way. In the case of this demo, `02_Storage` will call the same reusable workflows used in the first `caller` workflow to create a terraform deployment `PLAN` based on the repository `path: ./02_Storage` containing the terraform ROOT module/configuration for one General-V2 and one Data Lake V2 Storage storage account. The plan artifacts are again validated, compressed and uploaded into the workflow artifacts, the caller workflow `02_Storage` will then call and trigger the second reusable workflow `az_tf_apply` that will download and decompress the `PLAN` artifact and trigger the deployment based on the new separate plan.

**03_etc_etc:**

- The same process can be repeated to create more terraform root modules/configurations to deploy even more resources in a non-monolithic way etc etc...

## IaC Security Scanning (TFSEC)

In addition IaC scanning using TFSEC has also been applied to the `PLAN` **reusable workflow**.  

Each terraform configuration, when calling the `PLAN` **reusable workflow** will be scanned for any Terraform IaC vulnerabilities and misconfigurations and the results will be published on the GitHub Projects `Security` tab e.g:  

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/Azure-Terraform-Deployments/master/assets/tfsec.png)
