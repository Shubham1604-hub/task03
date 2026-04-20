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

variable "ip_restrictions" {
  type = list(object({
    name        = string
    ip_address  = optional(string)
    service_tag = optional(string)
    action      = string
    priority    = number
  }))
  description = "List of IP restrictions for the Web App"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Web App"
  default     = {}
}