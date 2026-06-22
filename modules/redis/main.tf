resource "azurerm_redis_cache" "redis" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity         # Smallest size for Basic/Standard (0 for Basic C0, 1 for Standard C1)
  family              = "C"        # "C" stands for Cache (Basic/Standard tier)
  sku_name            = var.sku_name # Maps directly to your variable (e.g., "Standard" or "Basic")
  minimum_tls_version = "1.2"
  tags                = var.tags

  redis_configuration {}
}
