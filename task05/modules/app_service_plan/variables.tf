variable "name" {
  type        = string
  description = "Name of the App Service Plan"
}

variable "location" {
  type        = string
  description = "Location for the App Service Plan"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "sku" {
  type        = string
  description = "SKU for the App Service Plan"
  default     = "S1"
}

variable "worker_count" {
  type        = number
  description = "Number of workers"
  default     = 1
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the App Service Plan"
  default     = {}
}