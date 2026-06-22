data "azurerm_resource_group" "target_rg" {
  name = var.resource_group_name
}

# Managed Identity
module "managed_identity" {
  source              = "../../modules/managed-identity"
  name                = local.names.managed_identity
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  tags                = local.common_tags
}

# Key Vault
module "key_vault" {
  source              = "../../modules/key-vault"
  name                = local.names.key_vault
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  tenant_id           = var.tenant_id
  tags                = local.common_tags
}

# Redis
module "redis" {
  source              = "../../modules/redis"
  name                = local.names.redis
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  tags                = local.common_tags
}

# Service Bus
module "service_bus" {
  source              = "../../modules/service-bus"
  name                = local.names.service_bus
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  tags                = local.common_tags
}

# Azure Container Registry (ACR)
module "acr" {
  source              = "../../modules/acr"
  name                = local.names.acr
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  tags                = local.common_tags
}

# Container App Environment
module "container_app_environment" {
  source              = "../../modules/container-app-environment"
  name                = local.names.container_app_environment
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  tags                = local.common_tags
}

# Container App
module "container_app" {
  source                       = "../../modules/container-app"
  name                         = local.names.container_app
  location                     = var.location
  resource_group_name          = data.azurerm_resource_group.target_rg.name
  container_app_environment_id = module.container_app_environment.id
  image                        = var.container_app_image
  tags                         = local.common_tags
  identity_ids                 = [module.managed_identity.id]
}

# Static Web App
module "static_web_app" {
  source               = "../../modules/static-web-app"
  name                 = local.names.static_web_app
  staticWebAppLocation = var.staticWebAppLocation
  resource_group_name  = data.azurerm_resource_group.target_rg.name
  tags                 = local.common_tags
}

# Storage Accounts (for_each pattern)
module "storage_accounts" {
  for_each            = local.storage_accounts
  source              = "../../modules/storage-account"
  name                = each.value
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  tags                = local.common_tags
}

resource "azurerm_storage_container" "function_app" {
  for_each              = local.function_app_deployments
  name                  = each.value
  storage_account_id    = module.storage_accounts[each.key].id
  container_access_type = "private"
}

# App Service Plan for Function App
# resource "azurerm_service_plan" "function_app_plan" {
#   name                = "${local.resource_name}-plan"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.target_rg.name
#   os_type             = "Windows"
#   sku_name            = "Y1" # <--- This single attribute replaces the entire nested sku {} block
# }

module "app_service_plans" {
  for_each            = local.app_service_plans
  source              = "../../modules/app-service-plan"

  name                = each.value
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name

  os_type             = var.os_type
  sku_name            = each.key == "api" ? var.api_sku_name : var.sku_name

  tags                = local.common_tags
}

module "function_apps" {
  for_each                   = local.function_apps
  source                     = "../../modules/function-app"
  name                       = each.value
  location                   = var.location
  resource_group_name        = data.azurerm_resource_group.target_rg.name
  app_service_plan_id        = module.app_service_plans[each.key].id
  storage_account_name       = module.storage_accounts[each.key].name
  storage_account_access_key = module.storage_accounts[each.key].primary_access_key
  storage_container_endpoint = "${module.storage_accounts[each.key].primary_blob_endpoint}${azurerm_storage_container.function_app[each.key].name}"
  runtime_name               = "python"
  runtime_version            = "3.12"
  tags                       = local.common_tags
}

# Application Insights
module "app_insights" {
  for_each            = local.app_insights
  source              = "../../modules/app-insights"
  name                = each.value
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  tags                = local.common_tags
}

# Log Analytics
module "log_analytics" {
  source              = "../../modules/log-analytics"
  name                = local.names.log_analytics
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  tags                = local.common_tags
}

module "ai_search" {
  source              = "../../modules/ai-search"
  name                = local.names.ai_search
  location            = var.location
  resource_group_name = data.azurerm_resource_group.target_rg.name
  sku                 = var.ai_search_sku
  replica_count       = var.ai_search_replica_count
  partition_count     = var.ai_search_partition_count
  tags                = local.common_tags
}

module "azure_openai" {
  source                = "../../modules/azure-openai"
  name                  = local.names.azure_openai
  location              = var.openai_location
  resource_group_name   = data.azurerm_resource_group.target_rg.name
  sku_name              = var.openai_sku_name
  custom_subdomain_name = substr(replace(local.names.openai_subdomain, "-", ""), 0, 64)
  deployments           = var.openai_deployments
  tags                  = local.common_tags
}

# API Management (APIM)
# module "apim" {
#   source              = "../../modules/apim"
#   name                = "${local.name_prefix}-${local.abbreviations.api_management}"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.target_rg.name
#   publisher_name      = var.apim_publisher_name
#   publisher_email     = var.apim_publisher_email
#   sku_name            = var.apim_sku_name
#   sku_capacity        = var.apim_sku_capacity
#   tags                = local.common_tags
# }

# Role Assignment
#module "role_assignment" {
#  source               = "../../modules/role-assignment"
#  scope                = var.role_assignment_scope
#  role_definition_name = var.role_assignment_role_definition_name
#  principal_id         = module.managed_identity.principal_id
#}
#
## Grant ACR pull rights to the managed identity used by container apps
#resource "azurerm_role_assignment" "acr_pull" {
#  scope                = module.acr.id
#  role_definition_name = "AcrPull"
#  principal_id         = module.managed_identity.principal_id
#}
