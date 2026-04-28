# Resource Group
resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

# Redis Cache Module
module "redis" {
  source = "./modules/redis"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  redis_name          = local.redis_name
  capacity            = var.redis_capacity
  sku                 = var.redis_sku
  family              = var.redis_family
  keyvault_id         = module.keyvault.keyvault_id
  tags                = local.common_tags

  # Wait for keyvault access policy before creating secrets
  depends_on = [module.keyvault]
}

# Key Vault Module
module "keyvault" {
  source = "./modules/keyvault"
  
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  keyvault_name      = local.keyvault_name
  tenant_id          = data.azurerm_client_config.current.tenant_id
  current_user_object_id = data.azurerm_client_config.current.object_id
  tags               = local.common_tags
}

# ACR Module
module "acr" {
  source = "./modules/acr"
  
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  acr_name           = local.acr_name
  sku                = var.acr_sku
  docker_image_name  = var.docker_image_name
  image_tag          = local.image_tag
  git_pat           = var.git_pat
  tags               = local.common_tags
}

# AKS Module
module "aks" {
  source = "./modules/aks"
  
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  aks_name           = local.aks_name
  node_count         = var.aks_node_count
  node_size          = var.aks_node_size
  os_disk_type       = var.aks_os_disk_type
  acr_id             = module.acr.acr_id
  keyvault_id        = module.keyvault.keyvault_id
  redis_url_secret_name  = local.redis_url_secret_name
  redis_password_secret_name = local.redis_password_secret_name
  tenant_id          = data.azurerm_client_config.current.tenant_id
  tags               = local.common_tags
}

# ACI Module
module "aci" {
  source = "./modules/aci"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  aci_name            = local.aci_name
  sku                 = var.aci_sku
  acr_login_server    = module.acr.acr_login_server
  acr_username        = module.acr.acr_admin_username
  acr_password        = module.acr.acr_admin_password
  docker_image_name   = var.docker_image_name
  image_tag           = local.image_tag
  redis_hostname      = module.redis.redis_hostname
  redis_primary_key   = module.redis.redis_primary_key
  tags                = local.common_tags

  depends_on = [module.acr, module.redis]
}

# Deploy Kubernetes Manifests
resource "kubectl_manifest" "secret_provider_class" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.aks_kv_access_identity_id
    kv_name                     = local.keyvault_name
    redis_url_secret_name       = local.redis_url_secret_name
    redis_password_secret_name  = local.redis_password_secret_name
    tenant_id                   = data.azurerm_client_config.current.tenant_id
  })
  
  depends_on = [module.aks]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = var.docker_image_name
    image_tag        = local.image_tag
  })
  
  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }
  
  depends_on = [kubectl_manifest.secret_provider_class, module.acr]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")
  
  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }
  
  depends_on = [kubectl_manifest.deployment]
}

# Data source to get LoadBalancer IP
data "kubernetes_service" "app_service" {
  metadata {
    name = "redis-flask-app-service"
  }
  
  depends_on = [kubectl_manifest.service]
}

# Current Azure client config
data "azurerm_client_config" "current" {}