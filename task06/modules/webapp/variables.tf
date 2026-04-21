variable "asp_name" {
  type        = string
  description = "Name of the App Service Plan"
}

variable "webapp_name" {
  type        = string
  description = "Name of the Web App"
}

variable "asp_sku" {
  type        = string
  description = "SKU of the App Service Plan (e.g., F1, B1, S1)"
}


variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the Web App"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "location"
}

variable "os_type" {
  type        = string
  description = "os type"
}

variable "sql_connection_string" {
  type        = string
  description = "SQL connection string for the Web App"
  sensitive   = true
}

variable "dotnet_version" {
  description = "The .NET version for the Linux Web App"
  type        = string
}