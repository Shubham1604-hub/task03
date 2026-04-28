variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "redis_name" {
  description = "Redis cache name"
  type        = string
}

variable "capacity" {
  description = "Redis cache capacity"
  type        = number
}

variable "sku" {
  description = "Redis SKU"
  type        = string
}

variable "family" {
  description = "Redis SKU family"
  type        = string
}

variable "keyvault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "redis_url_secret_name" {
  description = "Secret name for Redis URL"
  type        = string
  default     = "redis-hostname"
}

variable "redis_password_secret_name" {
  description = "Secret name for Redis password"
  type        = string
  default     = "redis-primary-key"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}