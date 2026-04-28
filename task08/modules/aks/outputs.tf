output "id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "kube_config_raw" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "kv_identity_client_id" {
  value = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
}

output "kv_identity_object_id" {
  value = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id
}

output "kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}