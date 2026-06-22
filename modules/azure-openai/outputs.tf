output "id" {
  value = azurerm_cognitive_account.this.id
}

output "name" {
  value = azurerm_cognitive_account.this.name
}

output "endpoint" {
  value = azurerm_cognitive_account.this.endpoint
}

output "deployment_names" {
  value = [for d in azurerm_cognitive_deployment.deployments : d.name]
}
