variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "acr_name" {
  description = "ACR name"
  type        = string
}

variable "sku" {
  description = "ACR SKU"
  type        = string
  default     = "Basic"
}

variable "docker_image_name" {
  description = "Docker image name"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "git_pat" {
  description = "Git personal access token"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}