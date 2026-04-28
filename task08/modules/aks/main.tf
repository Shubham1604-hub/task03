resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.aks_dns_prefix

  default_node_pool {
    name            = var.aks_node_pool_name
    node_count      = var.aks_node_count
    vm_size         = var.aks_node_vm_size
    os_disk_type    = var.os_disk_type
    os_disk_size_gb = var.os_disk_size_gb
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}


data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"

  principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

resource "azurerm_key_vault_access_policy" "aks" {
  key_vault_id = var.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id

  # 👇 AKS managed identity
  object_id = azurerm_kubernetes_cluster.aks.identity[0].principal_id

  secret_permissions = [
    "Get",
    "List"
  ]

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

resource "azurerm_key_vault_access_policy" "aks_secrets_provider" {
  key_vault_id = var.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id

  # 👇 Key Vault secrets provider identity (used by CSI driver)
  object_id = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = [
    "Get",
    "List"
  ]

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}
