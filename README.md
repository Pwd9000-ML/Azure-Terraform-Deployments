# Azure-Terraform-Deployments

Template repository - Use to deploy Azure Resources using Terraform and **GitHub Reusable Workflows**.  

There's also a demo workflow called: [Marketplace_Example.yml](https://github.com/Pwd9000-ML/Azure-Terraform-Deployments/blob/master/.github/workflows/Marketplace_Example.yml) which shows how to use my **Public Marketplace GitHub Actions** instead of reusable workflows. I have put more development effort into the public actions and so they contain more features such as the ability to `Deploy` or `Destroy` Terraform plans.  

You can see more detail on the public actions here:  

* **[Terraform Plan for AZURE](https://github.com/marketplace/actions/terraform-plan-for-azure).**
* **[Terraform Apply for AZURE](https://github.com/marketplace/actions/terraform-apply-for-azure).**  

For more in depth details on usage and examples I also have a detailed online tutorial on my blog:  
See [Part 1](https://dev.to/pwd9000/multi-environment-azure-deployments-with-terraform-and-github-2450) if you want to use **GitHub Reusable Workflows**.  
Or [Part 2](https://dev.to/pwd9000/multi-environment-azure-deployments-with-terraform-and-github-part-2-pdl) if you want to use my **Public Marketplace GitHub Actions** instead.

This repository can be reused by anyone to:  

- Learn about GitHub reusable workflows.
- Learn about GitHub Actions.
- Learn about terraform deployments in AZURE using GitHub.
- Learn about multi-stage deployments and approvals in GitHub.
- Learn how to build Terraform modules using a non-monolithic approach.
- Utilize examples shown here in your own organization to build AZURE Infrastructure at scale.

Showcasing how to use GitHub reusable workflows and GitHub environments to build enterprise scale multi environment infrastructure deployments in Azure using a non-monolithic approach, to construct and simplify complex terraform deployments into simpler manageable work streams and reduce duplicate workflow code by utilizing reusable GitHub workflows.

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/Azure-Terraform-Deployments/master/assets/main.png)

In this demo repository, each `caller` workflow is numbered and can be independently deployed e.g:  

**01_Foundation:**

- The first `caller` workflow `01_Foundation` will call and trigger a reusable workflow `az_tf_plan` and create a foundational terraform deployment `PLAN` based on the repository `path: ./01_Foundation` containing the terraform ROOT module/configuration of an Azure Resource Group and key vault. The plan artifacts are validated, compressed and uploaded into the workflow artifacts, the caller workflow `01_Foundation` will then call and trigger the second reusable workflow `az_tf_apply` that will download and decompress the `PLAN` artifact and trigger the deployment based on the plan. (Also demonstrated is how to use GitHub Environments to do multi staged environment based deployments with approvals - Optional).

**02_Storage:**

- Next the second `caller` workflow `02_Storage` can be used and triggered independently to expand on the first deployment in a separate state file to deploy some additional resources, building up the resource inventory in a non-monolithic way. In the case of this demo, `02_Storage` will call the same reusable workflows used in the first `caller` workflow to create a terraform deployment `PLAN` based on the repository `path: ./02_Storage` containing the terraform ROOT module/configuration for one General-V2 and one Data Lake V2 Storage storage account. The plan artifacts are again validated, compressed and uploaded into the workflow artifacts, the caller workflow `02_Storage` will then call and trigger the second reusable workflow `az_tf_apply` that will download and decompress the `PLAN` artifact and trigger the deployment based on the new separate plan.

**03_etc_etc:**

- The same process can be repeated to create more terraform root modules/configurations to deploy even more resources in a non-monolithic way etc etc...

## IaC Security Scanning (TFSEC)

In addition IaC scanning using TFSEC has also been applied to the `PLAN` **reusable workflow**, using the input `enable_TFSEC`. By default this setting is set to `FALSE`.  

**NOTE:** If you are using a **Private** repository you will need a **GitHub Enterprise** account to enable code scanning with TFSEC. The code scanning feature is included however on any **Public** repositories. If you are using a **Private** repository and do not have an enterprise account, leave this setting on the default: `FALSE` and have a look at my other blog post on [IaC Scanning with TFSEC for VsCode (Extension)](https://dev.to/pwd9000/iac-scanning-with-tfsec-for-vscode-extension-27h8) instead.

Each terraform configuration, when calling the `PLAN` **reusable workflow** will be scanned for any Terraform IaC vulnerabilities and misconfigurations and the results will be published on the GitHub Projects `Security` tab e.g:  

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/Azure-Terraform-Deployments/master/assets/tfsec.png)

## Dependabot

* Dependabot is enabled to check dependencies for all `github-workflows` as well as each `Terraform` module version.
* Dependabot will open a PR on the `master` branch with the version bump automatically.
* The workflow `Marketplace_Example_Tests.yml` will run upon a Dependabot automated PR to run a `plan` as a test with the new versions.
* Dependabot cannot use `Actions Secrets`, thus the same secrets are added to the GitHub repository `dependabot secrets`.
* Terraform dependencies are tested using the [Marketplace_Example_Tests.yml](https://github.com/Pwd9000-ML/Azure-Terraform-Deployments/blob/master/.github/workflows/Marketplace_Example_Tests.yml) workflow and additional permissions are added due to the following [documentation](https://docs.github.com/en/code-security/supply-chain-security/keeping-your-dependencies-updated-automatically/automating-dependabot-with-github-actions):

Dependabot is able to trigger GitHub Actions workflows on its pull requests and comments; however, certain events are treated differently.

For workflows initiated by Dependabot `(github.actor == "dependabot[bot]")` using the `pull_request`, `pull_request_review`, `pull_request_review_comment`, and `push` events, the following restrictions apply:

* `GITHUB_TOKEN` has read-only permissions by default.
* Secrets are populated from `Dependabot secrets`. GitHub Actions secrets are not available!

```yml
jobs:
# Dependabot will open a PR on terraform version changes, this 'dependabot' job is only used to test TF version changes by running a plan.
  dependabot:
    runs-on: ubuntu-latest
    permissions:
      pull-requests: write ## Additional GITHUB_TOKEN permission for the dependabot job
      issues: write ## Additional GITHUB_TOKEN permission for the dependabot job
      repository-projects: write ## Additional GITHUB_TOKEN permission for the dependabot job
    if: ${{ github.actor == 'dependabot[bot]' }} ## Run test against the automatic dependabot PR raised
```
