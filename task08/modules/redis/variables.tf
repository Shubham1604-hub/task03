variable "redis_name" {
  description = "Redis Cache name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "redis_capacity" {
  description = "Redis capacity"
  type        = number
}

variable "redis_sku_name" {
  description = "Redis SKU name"
  type        = string
}

variable "redis_family" {
  description = "Redis SKU family"
  type        = string
}

variable "kv_id" {
  description = "Key Vault ID"
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Secret name for Redis primary key"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Secret name for Redis hostname"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map(string)
}