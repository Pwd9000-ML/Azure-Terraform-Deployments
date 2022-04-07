#Log into Azure
#az login

# Setup Variables.
$randomInt = Get-Random -Maximum 9999
$subscriptionId = (get-azcontext).Subscription.Id
$resourceGroupName = "Demo-Terraform-Core-Backend-RG"
$storageName = "tfgithubbackendsa$randomInt"
$kvName = "tf-core-backend-kv$randomInt"
$appName="tf-core-github-SPN$randomInt"
$region = "uksouth"

# Create a resource resourceGroupName
az group create --name "$resourceGroupName" --location "$region"

# Create a Key Vault
az keyvault create `
    --name "$kvName" `
    --resource-group "$resourceGroupName" `
    --location "$region" `
    --enable-rbac-authorization

# Authorize the operation to create a few secrets - Signed in User (Key Vault Secrets Officer)
az ad signed-in-user show --query objectId -o tsv | foreach-object {
    az role assignment create `
        --role "Key Vault Secrets Officer" `
        --assignee "$_" `
        --scope "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.KeyVault/vaults/$kvName"
    }

# Create an azure storage account - Terraform Backend Storage Account
az storage account create `
    --name "$storageName" `
    --location "$region" `
    --resource-group "$resourceGroupName" `
    --sku "Standard_LRS" `
    --kind "StorageV2" `
    --https-only true `
    --min-tls-version "TLS1_2"

# Authorize the operation to create the container - Signed in User (Storage Blob Data Contributor Role)
az ad signed-in-user show --query objectId -o tsv | foreach-object { 
    az role assignment create `
        --role "Storage Blob Data Contributor" `
        --assignee "$_" `
        --scope "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Storage/storageAccounts/$storageName"
    }

#Create Upload container in storage account to store terraform state files
Start-Sleep -s 40
az storage container create `
    --account-name "$storageName" `
    --name "tfstate" `
    --auth-mode login

# Create Terraform Service Principal and assign RBAC Role on Key Vault 
$spnJSON = az ad sp create-for-rbac --name $appName `
    --role "Key Vault Secrets Officer" `
    --scopes /subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.KeyVault/vaults/$kvName 

# Save new Terraform Service Principal details to key vault
$spnObj = $spnJSON | ConvertFrom-Json
foreach($object_properties in $spnObj.psobject.properties) {
    If ($object_properties.Name -eq "appId") {
        $null = az keyvault secret set --vault-name $kvName --name "ARM-CLIENT-ID" --value $object_properties.Value
    }
    If ($object_properties.Name -eq "password") {
        $null = az keyvault secret set --vault-name $kvName --name "ARM-CLIENT-SECRET" --value $object_properties.Value
    }
    If ($object_properties.Name -eq "tenant") {
        $null = az keyvault secret set --vault-name $kvName --name "ARM-TENANT-ID" --value $object_properties.Value
    }
}
$null = az keyvault secret set --vault-name $kvName --name "ARM-SUBSCRIPTION-ID" --value $subscriptionId

# Assign additional RBAC role to Terraform Service Principal Subscription as Contributor and access to backend storage
az ad sp list --display-name $appName --query [].appId -o tsv | ForEach-Object {
    az role assignment create --assignee "$_" `
        --role "Contributor" `
        --subscription $subscriptionId

    az role assignment create --assignee "$_" `
        --role "Storage Blob Data Contributor" `
        --scope "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Storage/storageAccounts/$storageName" `
    }
