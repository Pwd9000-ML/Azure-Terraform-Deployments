resource_group_name = "Demo-Infra-Uat-Rg"
location            = "UKSouth"
key_vault_name      = "Pwd9000-Infra-Uat-Kv"
use_rbac_mode       = true
tags = {
  terraformDeployment = "true",
  GithubRepo          = "https://github.com/Pwd9000-ML/Azure-Terraform-Deployments"
  Environment         = "UAT"
}