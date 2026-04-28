data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = var.kv_name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = var.sku_name

  tenant_id = data.azurerm_client_config.current.tenant_id

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "current" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge"
  ]
}