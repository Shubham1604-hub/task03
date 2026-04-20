resource "azurerm_windows_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id

  site_config {
    ip_restriction {
      name       = "allow-ip"
      ip_address = "${var.allow_ip_address}/32"
      action     = "Allow"
      priority   = 100
    }

    ip_restriction {
      name        = "allow-tm"
      service_tag = "AzureTrafficManager"
      action      = "Allow"
      priority    = 200
    }

    ip_restriction {
      name       = "deny-all"
      ip_address = "0.0.0.0/0"
      action     = "Deny"
      priority   = 300
    }
  }

  tags = var.tags
}