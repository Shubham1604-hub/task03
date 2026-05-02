resource "azurerm_subnet" "subnet" {
  name                 = local.afw_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.afw_subnet_address_prefix]
}

resource "azurerm_public_ip" "afw_public_ip" {
  name                = local.afw_public_ip_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_firewall" "afw" {
  name                = local.afw_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku_name            = local.afw_sku_name
  sku_tier            = var.afw_sku_tier

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.afw_public_ip.id
  }
}

resource "azurerm_route_table" "rt" {
  name                = local.route_table_name
  resource_group_name = var.rg_name
  location            = var.rg_location
}

resource "azurerm_route" "route_to_afw" {
  name                   = local.route_name
  resource_group_name    = var.rg_name
  route_table_name       = azurerm_route_table.rt.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.afw.ip_configuration[0].private_ip_address
}

resource "azurerm_route" "route_health_probe" {
  name                = join("", [local.name_prefix, "health-probe-route"])
  resource_group_name = var.rg_name
  route_table_name    = azurerm_route_table.rt.name
  address_prefix      = "168.63.129.16/32"
  next_hop_type       = "Internet"
}

resource "azurerm_route" "route_imds" {
  name                = join("", [local.name_prefix, "imds-route"])
  resource_group_name = var.rg_name
  route_table_name    = azurerm_route_table.rt.name
  address_prefix      = "169.254.169.254/32"
  next_hop_type       = "Internet"
}

resource "azurerm_subnet_route_table_association" "association" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.rt.id
}

resource "azurerm_firewall_application_rule_collection" "app_rule_collection" {
  name                = join("", [local.name_prefix, "app-rule-collection"])
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 100
  action              = "Allow"

  rule {
    name             = "allow-web"
    source_addresses = ["*"]
    target_fqdns     = ["microsoft.com", "docker.io"]

    dynamic "protocol" {
      for_each = local.app_rule_protocols
      content {
        type = protocol.value.type
        port = protocol.value.port
      }
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "net_rule_collection" {
  name                = join("", [local.name_prefix, "net-rule-collection"])
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 200
  action              = "Allow"

  rule {
    name                  = "allow-internet"
    source_addresses      = ["*"]
    destination_addresses = ["*"]
    destination_ports     = ["80", "443"]
    protocols             = ["TCP"]
  }
}

resource "azurerm_firewall_nat_rule_collection" "nat_rule_collection" {
  name                = join("", [local.name_prefix, "nat-rule-collection"])
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 300
  action              = "Dnat"

  rule {
    name                  = "nginx-rule"
    source_addresses      = ["*"]
    destination_ports     = ["80"]
    destination_addresses = [azurerm_public_ip.afw_public_ip.ip_address]
    translated_address    = var.aks_lb_ip_address
    translated_port       = "80"
    protocols             = ["TCP"]
  }
}
