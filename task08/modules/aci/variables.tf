variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "aci_name" {
  description = "Name of the Azure Container Instance"
  type        = string
}

variable "location" {
  description = "Location of the Azure Container Instance"
  type        = string
}

variable "sku_name" {
  description = "ACI SKU"
  type        = string
}

variable "tags" {
  description = "Tags for the Azure Container Instance"
  type        = map(string)
}

variable "ip_type" {
  description = "Public IP type for the Azure Container Instance"
  type        = string
}

variable "os_type" {
  description = "os type"
  type        = string
}

variable "acr_login_server" {
  description = "login server for acr"
  type        = string
}

variable "acr_username" {
  description = "username for acr"
  type        = string
}

variable "acr_password" {
  description = "password for acr"
  type        = string
}

variable "docker_image_name" {
  description = "Docker image name"
  type        = string
}

variable "cpu" {
  description = "CPU cores for the container"
  type        = number
}

variable "memory" {
  description = "Memory in GB for the container"
  type        = number
}


variable "dns_label_name" {
  description = "DNS label name for the Azure Container Instance"
  type        = string
}

variable "application_port" {
  description = "Port on which the application will run"
  type        = number
}

variable "redis_port" {
  description = "Port on which Redis is running"
  type        = number
}

variable "redis_ssl_mode" {
  description = "SSL mode for Redis connection"
  type        = string
}

variable "redis_url" {
  description = "URL for Redis connection"
  type        = string
}

variable "redis_password" {
  description = "password for redis"
  type        = string
}


