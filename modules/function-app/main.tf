#resource "azurerm_linux_function_app" "function_app" {
#  name                       = var.name
#  location                   = var.location
#  resource_group_name        = var.resource_group_name
#  service_plan_id            = var.app_service_plan_id
#  storage_account_name       = var.storage_account_name
#  storage_account_access_key = var.storage_account_access_key
#  tags                       = var.tags
#
#  # site_config is intentionally omitted. For FlexConsumption plans the provider
#  # manages the function app config (FunctionAppConfig) automatically. Manually
#  # setting `linux_fx_version` causes a "Value for unconfigurable attribute" error.
#}

resource "azurerm_function_app_flex_consumption" "function_app" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  service_plan_id           = var.app_service_plan_id
  virtual_network_subnet_id = var.virtual_network_subnet_id
  #vnet_route_all_enabled    = true

  storage_container_type            = "blobContainer"
  storage_container_endpoint        = var.storage_container_endpoint
  storage_authentication_type       = "UserAssignedIdentity"
  storage_user_assigned_identity_id = var.user_assigned_identity_id

  identity {
    type         = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }

  runtime_name           = var.runtime_name
  runtime_version        = var.runtime_version
  maximum_instance_count = 50
  instance_memory_in_mb  = 2048

  site_config {}

  tags = var.tags
}