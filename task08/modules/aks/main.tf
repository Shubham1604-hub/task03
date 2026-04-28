resource "azurerm_kubernetes_cluster" "main" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aks_name
  
  default_node_pool {
    name           = "system"
    node_count     = var.node_count
    vm_size      = var.node_size
    os_disk_type = var.os_disk_type
  }
  
  identity {
    type = "SystemAssigned"
  }
  
  # Enable CSI driver for secrets
  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "5m"
  }
  
  tags = var.tags
}

# Role assignment to allow AKS to pull images from ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}

# Key Vault access policy for AKS to get secrets
resource "azurerm_key_vault_access_policy" "aks_kv_access" {
  key_vault_id = var.keyvault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  
  secret_permissions = [
    "Get",
    "List"
  ]
}