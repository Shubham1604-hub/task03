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

module "afw" {
  source = "./modules/afw"

  name_prefix       = var.name_prefix
  rg_name           = data.azurerm_resource_group.rg.name
  rg_location       = data.azurerm_resource_group.rg.location
  vnet_name         = data.azurerm_virtual_network.vnet.name
  aks_subnet_id     = data.azurerm_subnet.aks_subnet.id
  aks_lb_ip_address = var.aks_loadbalancer_ip
}
