variable "name" {
  type        = string
  description = "Name of the Windows Web App"
}

variable "location" {
  type        = string
  description = "Location for the Web App"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "service_plan_id" {
  type        = string
  description = "ID of the App Service Plan"
}

variable "allow_ip_address" {
  type        = string
  description = "IP address to allow access from"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Web App"
  default     = {}
}