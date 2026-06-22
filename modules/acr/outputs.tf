output "login_server" {
  description = "The login server URL for the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "admin_username" {
  description = "The ACR admin username"
  value       = azurerm_container_registry.acr.admin_username
}

output "admin_password" {
  description = "The ACR admin password"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}

output "id" {
  description = "The ID of the Azure Container Registry"
  value       = azurerm_container_registry.acr.id
}