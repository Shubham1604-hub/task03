variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "rg_location" {
  description = "Location of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "afw_subnet_address_prefix" {
  description = "Address prefix for the Azure Firewall subnet (must be at least /26)"
  type        = string
  default     = "10.0.10.0/24"
}

variable "afw_sku_tier" {
  description = "SKU tier for Azure Firewall (e.g., Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "aks_subnet_id" {
  description = "ID of the existing AKS subnet to associate with the route table"
  type        = string
}

variable "aks_lb_ip_address" {
  description = "Public IP address of the AKS load balancer (DNAT target)"
  type        = string
}
