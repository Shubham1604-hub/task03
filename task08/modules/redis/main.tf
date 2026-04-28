resource "azurerm_redis_cache" "main" {
  name                = var.redis_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku
  minimum_tls_version = "1.2"
  
  tags = var.tags
}

# Store Redis hostname in Key Vault
resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_url_secret_name
  value        = azurerm_redis_cache.main.hostname
  key_vault_id = var.keyvault_id
}

# Store Redis primary key in Key Vault
resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.redis_password_secret_name
  value        = azurerm_redis_cache.main.primary_access_key
  key_vault_id = var.keyvault_id
}