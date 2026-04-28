output "aci_fqdn" {
  value       = module.aci.aci_fqdn
  description = "The fully qualified domain name (FQDN) of the Azure Container Instance."
}

output "aks_lb_ip" {
  description = "Load Balancer IP address of APP in AKS"
  value       = data.kubernetes_service.app.status[0].load_balancer[0].ingress[0].ip
}