resource "random_password" "sql_password" {
  length  = 16
  special = true
}

resource "azurerm_mssql_server" "sql_server" {
  name                = var.sql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "12.0"

  administrator_login          = var.kv_secret_name_sql_admin_username
  administrator_login_password = random_password.sql_password.result

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "sql_firewall_rules" {
  name             = var.firewall_rule_name
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

resource "azurerm_mssql_firewall_rule" "azure_firewall_rules" {
  name             = "azure services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_database" "sql_database" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.sql_server.id

  sku_name = var.sql_db_service_model

  tags = var.tags
}

resource "azurerm_key_vault_secret" "sql_admin_username" {
  name         = var.kv_secret_name_sql_admin_username
  value        = azurerm_mssql_server.sql_server.administrator_login
  key_vault_id = var.key_vault_id

  tags = var.tags
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.kv_secret_name_sql_admin_password
  value        = random_password.sql_password.result
  key_vault_id = var.key_vault_id

  tags = var.tags
}
