output "container_registry" {
  value = {
    id             = azurerm_container_registry.acr.id
    login_server   = azurerm_container_registry.acr.login_server
    admin_username = azurerm_container_registry.acr.admin_username
    admin_password = azurerm_container_registry.acr.admin_password
  }
}