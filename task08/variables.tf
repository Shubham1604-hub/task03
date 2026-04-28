variable "name_prefix" {
  description = "prefix"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}


## redis vars

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

variable "redis_primary_key_secret_name" {
  description = "Secret name for Redis primary key"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Secret name for Redis hostname"
  type        = string
}

## keyvault variables

variable "kv_sku" {
  description = "Key Vault SKU"
  type        = string
}



# 📦 ACR


variable "acr_sku" {
  description = "ACR SKU"
  type        = string
}

variable "docker_image_name" {
  description = "Docker image name"
  type        = string
}

variable "repo_url" {
  description = "The URL of the Git repository containing the Dockerfile"
  type        = string
}

variable "git_pat" {
  description = "The Personal Access Token (PAT) for accessing the Git repository"
  type        = string
  sensitive   = true
}

## ACI variables

variable "aci_sku" {
  description = "ACI SKU"
  type        = string
}


variable "node_pool_name" {
  description = "AKS node pool name"
  type        = string
}

variable "node_count" {
  description = "Number of nodes"
  type        = number
}

variable "node_vm_size" {
  description = "VM size for nodes"
  type        = string
}

variable "os_disk_type" {
  description = "OS disk type"
  type        = string
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB"
  type        = number
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}

variable "aci_ip_type" {
  description = "ip type"
  type        = string
}

variable "aci_os_type" {
  description = "os type"
  type        = string
}

variable "aci_cpu" {
  description = "CPU cores for the container"
  type        = string
}

variable "aci_memory" {
  description = "Memory in GB for the container"
  type        = string
}

variable "aci_dns_label" {
  description = "label for dns"
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


