variable "kv_name" {
  description = "Key Vault name"
  type        = string
}


variable "sku_name" {
  description = "Key Vault SKU name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "rg_name" {
  description = "Resource Group name"
  type        = string
}



variable "tags" {
  description = "Tags for the Key Vault"
  type        = map(string)
}