resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.asp_sku

  os_type = var.os_type

  tags = var.tags

}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.asp.id

  connection_string {
    name  = "sql_connection_string"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }

  site_config {
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  tags = var.tags
}
