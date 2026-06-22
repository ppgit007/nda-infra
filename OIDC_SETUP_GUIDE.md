# Azure OIDC Setup Guide for GitHub Actions

This guide explains how to configure OpenID Connect (OIDC) federated identity credentials between GitHub and Azure for secure, keyless authentication.

## Why OIDC over Service Principals?

- **No secrets to rotate**: Uses temporary OIDC tokens issued by GitHub
- **Better security**: Reduces attack surface by eliminating static credentials
- **Audit trail**: GitHub and Azure track the authentication source
- **Enterprise-grade**: Recommended by Microsoft and GitHub for CI/CD

## Prerequisites

- Azure subscription with Owner or Contributor role
- GitHub repository admin access
- Azure CLI installed locally or access to Azure Portal

## Setup Steps

### Step 1: Create an Azure App Registration

```powershell
# Set variables
$APP_NAME = "github-terraform-deployment"
$TENANT_ID = "<your-azure-tenant-id>"
$SUBSCRIPTION_ID = "<your-azure-subscription-id>"

# Create the app registration
$APP = az ad app create `
  --display-name $APP_NAME `
  --query "appId" -o tsv

$OBJECT_ID = az ad app show --id $APP --query "id" -o tsv

Write-Host "App Registration Created:"
Write-Host "  Application ID: $APP"
Write-Host "  Object ID: $OBJECT_ID"
```

### Step 2: Create Federated Identity Credentials

```powershell
# For GitHub repository triggers (Pull Request)
az identity federated-credential create `
  --resource-group <resource-group> `
  --identity-name $APP_NAME `
  --name github-pr `
  --issuer "https://token.actions.githubusercontent.com" `
  --subject "repo:<github-org>/<repo-name>:pull_request" `
  --audiences "api://AzureADTokenExchange"

# For main branch pushes (Deployment)
az identity federated-credential create `
  --resource-group <resource-group> `
  --identity-name $APP_NAME `
  --name github-main `
  --issuer "https://token.actions.githubusercontent.com" `
  --subject "repo:<github-org>/<repo-name>:ref:refs/heads/main" `
  --audiences "api://AzureADTokenExchange"
```

### Step 3: Grant Azure Permissions

```powershell
# Get the application's service principal
$SERVICE_PRINCIPAL = az ad sp show `
  --id $APP `
  --query "id" -o tsv

# Assign Contributor role to subscription
az role assignment create `
  --role "Contributor" `
  --assignee-object-id $SERVICE_PRINCIPAL `
  --scope "/subscriptions/$SUBSCRIPTION_ID"

# For Terraform state storage, also grant Storage Blob Data Contributor
az role assignment create `
  --role "Storage Blob Data Contributor" `
  --assignee-object-id $SERVICE_PRINCIPAL `
  --scope "/subscriptions/$SUBSCRIPTION_ID"
```

### Step 4: Create GitHub Repository Secrets

In your GitHub repository, add these secrets (**Settings > Secrets and variables > Actions**):

1. **AZURE_CLIENT_ID**: The Application ID from Step 1
2. **AZURE_TENANT_ID**: Your Azure Tenant ID
3. **AZURE_SUBSCRIPTION_ID**: Your Azure Subscription ID

```powershell
# Display the values you need
Write-Host "Add these as GitHub Secrets:"
Write-Host "  AZURE_CLIENT_ID: $APP"
Write-Host "  AZURE_TENANT_ID: $TENANT_ID"
Write-Host "  AZURE_SUBSCRIPTION_ID: $SUBSCRIPTION_ID"
```

## Workflow Configuration

The updated workflows now:
- Use `ARM_USE_OIDC: true` to enable OIDC for Terraform AzureRM provider
- Set ARM_CLIENT_ID, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID from GitHub secrets
- Use `azure/login@v1` with OIDC parameters instead of static credentials
- Request `id-token: write` permission for GitHub token exchange

## Terraform Backend Configuration

Ensure your `backend.tf` supports OIDC. Example:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstatestorage"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
    use_oidc             = true
  }
}
```

## Troubleshooting

### Error: "Not all values are present"
- Ensure all three GitHub secrets are set: AZURE_CLIENT_ID, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID
- Verify secret names match exactly (case-sensitive)

### Error: "Federated credential not found"
- Check the issuer is exactly: `https://token.actions.githubusercontent.com`
- Verify subject format matches your GitHub organization and repository name
- Ensure federated credentials are created (not just the app registration)

### Error: "Not authorized to perform action"
- Verify the service principal has Contributor role on the subscription
- Check role assignment scope is correct

### Test OIDC Connection

```bash
# In your GitHub Actions workflow, add a test step:
- name: Test Azure OIDC Login
  uses: azure/login@v1
  with:
    client-id: ${{ secrets.AZURE_CLIENT_ID }}
    tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

- name: Verify Azure Context
  run: az account show
```

## References

- [Microsoft: GitHub-to-Azure OIDC](https://docs.microsoft.com/en-us/azure/active-directory/workload-identities/workload-identity-federation-create-trust-github)
- [Azure/login Action](https://github.com/Azure/login)
- [Terraform: Azure Provider OIDC](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#oidc_request_token)

## Next Steps

1. Run the setup commands above
2. Add the GitHub secrets
3. Push the updated workflows to main branch
4. Verify the plan workflow succeeds
5. Test apply workflow manually if needed
