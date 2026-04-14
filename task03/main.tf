# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "cmaz-frq948m6-mod3-rg"
  location = var.location

  tags = {
    Creator = "shubhamparsharam_patgavkar@epam.com"
  }
}

# Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "cmazfrq948m6sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Creator = "shubhamparsharam_patgavkar@epam.com"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "cmaz-frq948m6-mod3-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    Creator = "shubhamparsharam_patgavkar@epam.com"
  }
}

# Frontend Subnet
resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Backend Subnet
resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}