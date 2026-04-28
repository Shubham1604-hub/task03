output "aci_fqdn" {
  description = "Fully qualified domain name of the ACI instance"
  value       = azurerm_container_group.aci.fqdn
}

output "aci_ip_address" {
  description = "IP address of the ACI instance"
  value       = azurerm_container_group.aci.ip_address
}