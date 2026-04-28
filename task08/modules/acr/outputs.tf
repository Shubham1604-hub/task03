output "acr_id" {
  description = "ACR ID"
  value       = azurerm_container_registry.main.id
}

output "acr_login_server" {
  description = "ACR login server"
  value       = azurerm_container_registry.main.login_server
}

output "acr_admin_username" {
  description = "ACR admin username"
  value       = azurerm_container_registry.main.admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "ACR admin password"
  value       = azurerm_container_registry.main.admin_password
  sensitive   = true
}

output "acr_name" {
  description = "ACR name"
  value       = azurerm_container_registry.main.name
}