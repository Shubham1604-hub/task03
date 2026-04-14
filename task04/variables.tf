variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}
variable "http_rule_name" {
  description = "HTTP rule name"
  type        = string
}

variable "ip_conf_name" {
  description = "ip configuration name"
  type        = string
}

variable "ssh_rule_name" {
  description = "SSH rule name"
  type        = string
}
variable "nic_name" {
  description = "Network Interface name"
  type        = string
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

variable "pip_name" {
  description = "Public IP name"
  type        = string
}

variable "dns_label" {
  description = "DNS label"
  type        = string
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "creator_tag" {
  description = "Creator tag"
  type        = string
}

variable "admin_username" {
  description = "VM username"
  type        = string
}

variable "vm_password" {
  description = "VM password"
  type        = string
  sensitive   = true
}