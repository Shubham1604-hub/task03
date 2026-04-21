data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

module "sql" {
  source = "./modules/sql"

  sql_server_name = local.sql_server_name

  resource_group_name = local.rg_name
  location            = azurerm_resource_group.rg.location

  kv_secret_name_sql_admin_username = var.kv_secret_name_sql_admin_username
  kv_secret_name_sql_admin_password = var.kv_secret_name_sql_admin_password

  allowed_ip_address   = var.allowed_ip_address
  sql_database_name    = local.sql_db_name
  sql_db_service_model = var.sql_sku

  key_vault_id = data.azurerm_key_vault.kv.id

  firewall_rule_name = var.firewall_rule_name

  tags = var.tags

}

module "webapp" {
  source = "./modules/webapp"

  asp_name            = local.asp_name
  resource_group_name = local.rg_name
  location            = azurerm_resource_group.rg.location
  asp_sku             = var.asp_sku
  os_type             = var.os_type

  webapp_name           = local.app_name
  dotnet_version        = var.dotnet_version
  sql_connection_string = module.sql.sql_connection_string

  tags = var.tags
}