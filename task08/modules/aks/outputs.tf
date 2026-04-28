output "aks_cluster_id" {
  description = "AKS cluster ID"
  value       = azurerm_kubernetes_cluster.main.id
}

output "aks_cluster_kube_config" {
  description = "AKS cluster kubeconfig"
  value       = azurerm_kubernetes_cluster.main.kube_config
  sensitive   = true
}

output "aks_kv_access_identity_id" {
  description = "AKS Key Vault access identity ID"
  value       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.main.name
}