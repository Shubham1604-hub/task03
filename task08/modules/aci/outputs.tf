output "aci_fqdn" {
  description = "FQDN of ACI container group"
  value       = azurerm_container_group.main.fqdn
}

output "aci_ip_address" {
  description = "IP address of ACI container group"
  value       = azurerm_container_group.main.ip_address
}
