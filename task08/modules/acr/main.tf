resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.acr_sku
  tags                = var.tags

  admin_enabled = true
}

resource "azurerm_container_registry_task" "ACR-task" {

  name                  = "${var.acr_name}-task"
  container_registry_id = azurerm_container_registry.acr.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.repo_url
    context_access_token = var.git_pat
    image_names          = ["${var.image_name}:latest"]
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "run" {
  container_registry_task_id = azurerm_container_registry_task.ACR-task.id
}

