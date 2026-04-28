data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

module "kv" {
  source   = "./modules/keyvault"
  kv_name  = local.keyvault_name
  location = var.location
  rg_name  = azurerm_resource_group.rg.name
  sku_name = var.kv_sku
  tags     = var.tags
}

module "redis" {
  source = "./modules/redis"

  redis_name = local.redis_name
  location   = var.location

  rg_name        = azurerm_resource_group.rg.name
  redis_capacity = var.redis_capacity

  redis_sku_name = var.redis_sku_name
  redis_family   = var.redis_family
  tags           = var.tags

  redis_primary_key_secret_name = var.redis_primary_key_secret_name
  redis_hostname_secret_name    = var.redis_hostname_secret_name

  kv_id = module.kv.key_vault_id

  depends_on = [module.kv]
}

module "acr" {
  source = "./modules/acr"

  acr_name = local.acr_name
  location = var.location

  rg_name = azurerm_resource_group.rg.name
  acr_sku = var.acr_sku

  repo_url = var.repo_url
  git_pat  = var.git_pat

  image_name = var.docker_image_name

  tags = var.tags

}

module "aci" {
  source = "./modules/aci"

  aci_name = local.aci_name
  location = var.location

  rg_name = azurerm_resource_group.rg.name

  sku_name = var.aci_sku

  tags = var.tags

  ip_type = var.aci_ip_type
  os_type = var.aci_os_type

  acr_login_server = module.acr.container_registry.login_server
  acr_username     = module.acr.container_registry.admin_username
  acr_password     = module.acr.container_registry.admin_password

  docker_image_name = var.docker_image_name

  cpu    = var.aci_cpu
  memory = var.aci_memory

  dns_label_name = var.aci_dns_label


  redis_password = module.redis.redis_primary_key
  redis_url      = module.redis.redis_hostname

  redis_port       = var.redis_port
  redis_ssl_mode   = var.redis_ssl_mode
  application_port = var.application_port

  depends_on = [module.acr]
}


module "aks" {
  source = "./modules/aks"

  aks_name = local.aks_name
  location = var.location

  rg_name = azurerm_resource_group.rg.name

  aks_dns_prefix = local.aks_name

  aks_node_pool_name = var.node_pool_name
  aks_node_count     = var.node_count
  aks_node_vm_size   = var.node_vm_size

  key_vault_id = module.kv.key_vault_id

  os_disk_type    = var.os_disk_type
  os_disk_size_gb = var.os_disk_size_gb

  tags = var.tags

  acr_id = module.acr.container_registry.id

  depends_on = [module.kv]
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.kv_identity_client_id
    kv_name                    = module.kv.key_vault_name
    tenant_id                  = data.azurerm_client_config.current.tenant_id
    redis_url_secret_name      = "redis-hostname"
    redis_password_secret_name = "redis-primary-key"
  })

  depends_on = [module.aks, module.redis]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.container_registry.login_server
    app_image_name   = local.image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider, module.acr]
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

data "kubernetes_service" "app" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.service]
}
