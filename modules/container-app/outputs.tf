output "url" {
  value = azurerm_container_app.container_app.ingress[0].fqdn
}