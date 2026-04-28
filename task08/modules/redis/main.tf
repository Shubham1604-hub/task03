resource "azurerm_redis_cache" "redis" {
  name                = var.redis_name
  location            = var.location
  resource_group_name = var.rg_name
  capacity            = var.redis_capacity
  sku_name            = var.redis_sku_name
  family              = var.redis_family
  tags                = var.tags
}

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.redis_primary_key_secret_name
  value        = azurerm_redis_cache.redis.primary_access_key
  key_vault_id = var.kv_id
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_redis_cache.redis.hostname
  key_vault_id = var.kv_id
}

