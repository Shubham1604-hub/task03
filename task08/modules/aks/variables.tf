variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "node_count" {
  description = "Node count"
  type        = number
  default     = 1
}

variable "node_size" {
  description = "Node size"
  type        = string
  default     = "Standard_D2ads_v6"
}

variable "os_disk_type" {
  description = "OS disk type"
  type        = string
  default     = "Ephemeral"
}

variable "acr_id" {
  description = "ACR ID"
  type        = string
}

variable "keyvault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "redis_url_secret_name" {
  description = "Redis URL secret name"
  type        = string
}

variable "redis_password_secret_name" {
  description = "Redis password secret name"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}