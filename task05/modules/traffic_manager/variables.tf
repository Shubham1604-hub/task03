variable "name" {
  type        = string
  description = "Name of the Traffic Manager profile"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for Traffic Manager"
}

variable "routing_method" {
  type        = string
  description = "Routing method for Traffic Manager"
  default     = "Performance"
}

variable "endpoints" {
  type = map(object({
    name     = string
    target   = string
    location = string
  }))
  description = "Map of endpoints for Traffic Manager"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Traffic Manager profile"
  default     = {}
}