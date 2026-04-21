variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the resources"
}

variable "sql_server_name" {
  type        = string
  description = "Name of the SQL Server"
}

variable "sql_database_name" {
  type        = string
  description = "Name of the SQL Database"
}

variable "sql_db_service_model" {
  type        = string
  description = "Service model for the SQL Database (e.g., Basic, Standard, Premium)"
}

variable "allowed_ip_address" {
  description = "firewall values for db"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the SQL Database"
}

variable "key_vault_id" {
  type        = string
  description = "id of the key vault"
}

variable "kv_secret_name_sql_admin_username" {
  type        = string
  description = "secret name for sql admin username"
}

variable "kv_secret_name_sql_admin_password" {
  type        = string
  description = "secret name for sql admin password"
}

variable "firewall_rule_name" {
  type        = string
  description = "Name of the firewall rule for allowed IP address"
}