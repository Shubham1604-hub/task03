variable "name_prefix" {
  description = "Name prefix for all resources"
  type        = string
  default     = "cmtr-frq948m6-mod8"
}

variable "git_pat" {
  description = "Git personal access token for ACR task"
  type        = string
  sensitive   = true
}

variable "creator" {
  description = "Creator tag value"
  type        = string
  default     = "shubhamparsharam_patgavkar@epam.com"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "redis_capacity" {
  description = "Redis cache capacity"
  type        = number
  default     = 2
}

variable "redis_sku" {
  description = "Redis SKU"
  type        = string
  default     = "Basic"
}

variable "redis_family" {
  description = "Redis SKU family"
  type        = string
  default     = "C"
}

variable "acr_sku" {
  description = "ACR SKU"
  type        = string
  default     = "Basic"
}

variable "docker_image_name" {
  description = "Docker image name"
  type        = string
  default     = "cmtr-frq948m6-mod8-app"
}

variable "aci_sku" {
  description = "ACI SKU"
  type        = string
  default     = "Standard"
}

variable "aks_node_count" {
  description = "AKS default node pool count"
  type        = number
  default     = 1
}

variable "aks_node_size" {
  description = "AKS node size"
  type        = string
  default     = "Standard_D2ads_v6"
}

variable "aks_os_disk_type" {
  description = "AKS OS disk type"
  type        = string
  default     = "Ephemeral"
}