output "redis_id" {
  description = "ID of the created Redis Cache"
  value       = azurerm_redis_cache.redis.id
}

output "redis_hostname" {
  description = "redis hostname"
  value       = azurerm_redis_cache.redis.hostname
}

output "redis_primary_key" {
  description = "redis primary key"
  value       = azurerm_redis_cache.redis.primary_access_key
}

