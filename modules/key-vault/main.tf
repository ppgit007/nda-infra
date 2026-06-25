resource "azurerm_key_vault" "key_vault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
  tags                = var.tags

  network_acls {
    default_action             = var.network_acls_default_action
    bypass                     = var.network_acls_bypass
    ip_rules                   = var.network_acls_ip_rules
    virtual_network_subnet_ids = var.network_acls_subnet_ids
  }
}