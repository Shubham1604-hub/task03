resource "azurerm_container_registry" "main" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true

  tags = var.tags
}

# ACR Task to build Docker image from git repository
resource "azurerm_container_registry_task" "build_image" {
  name                  = "build-${var.docker_image_name}"
  container_registry_id = azurerm_container_registry.main.id

  platform {
    os           = "Linux"
    architecture = "amd64"
  }

  docker_step {
    dockerfile_path      = "task08/application/Dockerfile"
    context_path         = "https://github.com/Shubham1604-hub/task03.git#main"
    context_access_token = var.git_pat
    image_names          = ["${var.docker_image_name}:${var.image_tag}"]
    push_enabled         = true
  }

  source_trigger {
    name           = "source-trigger"
    repository_url = "https://github.com/Shubham1604-hub/task03.git"
    source_type    = "Github"
    branch         = "main"
    events         = ["commit"]

    authentication {
      token_type = "PAT"
      token      = var.git_pat
    }
  }

  # Container Registry Task Schedule to trigger the ACR task daily
  timer_trigger {
    name     = "daily-build"
    schedule = "0 0 * * *"
  }

  timeout_in_seconds = 3600

  agent_setting {
    cpu = 2
  }
}

# Trigger the build immediately on apply so the image is available
resource "null_resource" "trigger_acr_build" {
  depends_on = [azurerm_container_registry_task.build_image]

  provisioner "local-exec" {
    command = "az acr task run --name ${azurerm_container_registry_task.build_image.name} --registry ${var.acr_name}"
  }

  triggers = {
    always_run = timestamp()
  }
}
