resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "frontend" {
  resource_group_name  = var.resource_group_name
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  domain_name_label = var.dns_label

  tags = {
    Creator = var.creator_tag
  }

}

resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = {
    Creator = var.creator_tag
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    Creator = var.creator_tag
  }
}

#inbound rule for http
resource "azurerm_network_security_rule" "http" {
  name                        = "AllowHTTP"
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_resource_group.rg.name

  priority                   = 100
  direction                  = "Inbound"
  source_port_range          = "*"
  destination_port_range     = "80"
  protocol                   = "Tcp"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  access                     = "Allow"

}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "AllowSSH"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name

  direction                  = "Inbound"
  access                     = "Allow"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  protocol                   = "Tcp"
  priority                   = 110

}

resource "azurerm_network_interface_security_group_association" "assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2s_v2"
  admin_username      = var.admin_username
  admin_password      = var.vm_password

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "24_04-lts"
    version   = "latest"
  }

  tags = {
    Creator = var.creator_tag
  }

  # NGINX INSTALL
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx"
    ]

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.vm_password
      host     = azurerm_public_ip.pip.ip_address
    }
  }
}