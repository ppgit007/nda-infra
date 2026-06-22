# General Configuration
location                = "eastus"           # Azure region where resources will be deployed 
staticWebAppLocation    = "eastus2"          # Static Web App requires eastus2, westus2, etc.
environment             = "qa"               # Environment name (e.g., dev, staging, prod)
project                 = "nursedenial"        # Project name for resource naming
component               = "mycomponent"      # Component name for resource naming
owner                   = "pp@pp.com"        # Owner of the resources
resource_group_name     = "my-rg2"           # Name of the resource group (must be unique within the subscription)

# Key Vault
tenant_id = "d026fded-54e6-40ed-82bc-cb6a408bc4ed" # Replace with your Azure Tenant ID

# Container App
#container_app_image = "myregistry.azurecr.io/myapp:latest" # Replace with your container image
container_app_image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest" # Replace with your container image

# Function App
# function_app_service_plan_id            = "your-service-plan-id"            # Replace with your App Service Plan ID
# function_app_storage_account_name       = "myfnappstorageaccount"           # Replace with your Storage Account Name
# function_app_storage_account_access_key = "your-storage-account-access-key" # Replace with your Storage Account Access Key

# Function App Service Plan
os_type             = "Linux"
sku_name            = "Y1"

# API Management (APIM)
# apim_publisher_name  = "PP Publisher" # Replace with your APIM publisher name
# apim_publisher_email = "pp@pp.com"     # Replace with your APIM publisher email
# apim_sku_name        = "Developer"    # Replace with your desired APIM SKU (e.g., Developer, Basic, Standard, Premium)
# apim_sku_capacity    = 1              # Replace with the capacity for the selected SKU

# Role Assignment
#role_assignment_scope                = "/subscriptions/your-subscription-id/resourceGroups/your-resource-group" # Replace with your scope
#role_assignment_role_definition_name = "Contributor"                                                            # Replace with your desired role definition name

# Application Names
static_web_app_name = "my-static-web-app-001" # IMPORTANT: Must be globally unique across Azure
container_app_name  = "my-container-app"      # Replace with your desired Container App name
# function_app_name   = "my-function-app"       # Replace with your desired Function App name
key_vault_name      = "myvault001"            # IMPORTANT: Must be globally unique across Azure (3-24 alphanumeric+dashes)
