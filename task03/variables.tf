variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "frontend_subnet_name" {
  description = "Frontend subnet name"
  type        = string
}

variable "backend_subnet_name" {
  description = "Backend subnet name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "creator_tag" {
  description = "Creator tag value"
  type        = string
}