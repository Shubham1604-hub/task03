variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "aci_name" {
  description = "ACI name"
  type        = string
}

variable "acr_login_server" {
  description = "ACR login server"
  type        = string
}

variable "acr_username" {
  description = "ACR admin username"
  type        = string
  sensitive   = true
}

variable "acr_password" {
  description = "ACR admin password"
  type        = string
  sensitive   = true
}

variable "docker_image_name" {
  description = "Docker image name"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "redis_hostname" {
  description = "Redis hostname"
  type        = string
}

variable "redis_primary_key" {
  description = "Redis primary access key"
  type        = string
  sensitive   = true
}

variable "sku" {
  description = "ACI SKU"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}