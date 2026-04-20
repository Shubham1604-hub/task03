variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
  description = "map of resource group objects"
}

variable "app_service_plans" {
  type = map(object({
    name               = string
    worker_count       = number
    sku                = string
    resource_group_key = string
  }))

  description = "A map of App Service Plan objects"
}

variable "app_services" {
  type = map(object({
    name               = string
    resource_group_key = string
    service_plan_key   = string
  }))
  description = "A map of Windows Web App objects"
}

variable "traffic_manager" {
  type = object({
    name           = string
    resource_group = string
    routing_method = string
  })
  description = "Traffic Manager configuration"
}

variable "ip_restrictions" {
  type = list(object({
    name        = string
    priority    = number
    action      = string
    ip_address  = optional(string)
    service_tag = optional(string)
  }))
  description = "List of IP restrictions applied to all app services"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}