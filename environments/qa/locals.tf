locals {
  abbreviations = jsondecode(
    file("${path.root}/../../shared/abbreviations.json")
  )

  # Common tags to be applied to all resources
  common_tags = {
    environment = var.environment
    owner       = var.owner
    project     = var.project
  }

  # Naming convention for resources (with dashes)
  #resource_name = "${var.project}-${var.environment}-${var.component}"
  name_prefix = "${var.project}-${var.environment}"
  # Alphanumeric-only names for resources that don't support dashes (ACR, Storage Account)
  resource_name_alphanumeric = replace(local.name_prefix, "-", "")

  names = {
    static_web_app   = "${local.name_prefix}-${local.abbreviations.static_web_app}"
    key_vault        = "${local.name_prefix}-${local.abbreviations.key_vault}"
    managed_identity = "${local.name_prefix}-${local.abbreviations.managed_identity}"
    redis            = "${local.name_prefix}-${local.abbreviations.redis}"
    service_bus      = "${local.name_prefix}-${local.abbreviations.service_bus}"
    log_analytics    = "${local.resource_name_alphanumeric}-${local.abbreviations.log_analytics}"
    acr              = "${local.resource_name_alphanumeric}${local.abbreviations.container_registry}"
    container_app_environment = "${local.name_prefix}-${local.abbreviations.container_app_environment}"
    container_app    = "${local.name_prefix}-${local.abbreviations.container_app}"
    ai_search        = "${local.name_prefix}-${local.abbreviations.ai_search}"
    azure_openai     = "${local.name_prefix}-${local.abbreviations.azure_openai}"
    openai_subdomain = "${local.name_prefix}-${local.abbreviations.azure_openai}"
  }

  storage_accounts = {
    data = substr("${local.resource_name_alphanumeric}${local.abbreviations.storage_account}data", 0, 24)
    fn   = substr("${local.resource_name_alphanumeric}${local.abbreviations.storage_account}fn", 0, 24)
    api  = substr("${local.resource_name_alphanumeric}${local.abbreviations.storage_account}api", 0, 24)
  }

  app_insights = {
    fn  = "${local.name_prefix}-${local.abbreviations.application_insights}-fn"
    api = "${local.name_prefix}-${local.abbreviations.application_insights}-api"
  }

  app_service_plans = {
    fn  = "${local.resource_name_alphanumeric}-${local.abbreviations.app_service_plan}-fn"
    api = "${local.resource_name_alphanumeric}-${local.abbreviations.app_service_plan}-api"
  }

  function_apps = {
    fn  = "${local.resource_name_alphanumeric}-${local.abbreviations.function_app}"
    api = "${local.resource_name_alphanumeric}-${local.abbreviations.function_app}-api"
  }

  function_app_deployments = {
    fn  = "deployment-fn"
    api = "deployment-api"
  }

  
}