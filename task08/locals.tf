locals {
  # Resource names
  rg_name       = "${var.name_prefix}-rg"
  redis_name    = "${var.name_prefix}-redis"
  keyvault_name = "${var.name_prefix}-kv"
  acr_name      = replace("${var.name_prefix}cr", "-", "")
  aci_name      = "${var.name_prefix}-ci"
  aks_name      = "${var.name_prefix}-aks"

  # Redis secret names
  redis_url_secret_name      = "redis-hostname"
  redis_password_secret_name = "redis-primary-key"

  # Docker image details
  image_tag = formatdate("YYYYMMDDhhmmss", timestamp())

  # Common tags
  common_tags = {
    Creator = var.creator
  }
}