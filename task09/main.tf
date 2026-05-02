data "azurerm_resource_group" "rg" {
  name = local.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = local.virtual_network_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = local.aks_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_cluster_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_resources" "aks_nsg" {
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  type                = "Microsoft.Network/networkSecurityGroups"
}

module "afw" {
  source = "./modules/afw"

  name_prefix       = var.name_prefix
  rg_name           = data.azurerm_resource_group.rg.name
  rg_location       = data.azurerm_resource_group.rg.location
  vnet_name         = data.azurerm_virtual_network.vnet.name
  aks_subnet_id     = data.azurerm_subnet.aks_subnet.id
  aks_lb_ip_address = var.aks_loadbalancer_ip
}

resource "azurerm_network_security_rule" "allow_fw_to_lb" {
  name                        = "AllowAccessFromFirewallPublicIPToLoadBalancerIP"
  priority                    = 400
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = module.afw.firewall.public_ip_address
  destination_address_prefix  = var.aks_loadbalancer_ip
  resource_group_name         = data.azurerm_kubernetes_cluster.aks.node_resource_group
  network_security_group_name = data.azurerm_resources.aks_nsg.resources[0].name
}
