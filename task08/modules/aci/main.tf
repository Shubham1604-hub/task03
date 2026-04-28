resource "azurerm_container_group" "aci" {
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.rg_name

  os_type         = var.os_type
  ip_address_type = var.ip_type
  dns_name_label  = var.dns_label_name

  container {
    name   = "app-container"
    image  = "${var.acr_login_server}/${var.docker_image_name}:latest"
    cpu    = var.cpu
    memory = var.memory

    ports {
      port     = var.application_port
      protocol = "TCP"
    }

    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = var.redis_port
      REDIS_SSL_MODE = var.redis_ssl_mode
    }

    secure_environment_variables = {
      REDIS_URL = var.redis_url
      REDIS_PWD = var.redis_password
    }
  }

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_username
    password = var.acr_password
  }

  tags = var.tags
}

