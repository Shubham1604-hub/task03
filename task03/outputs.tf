output "rg_id" {
  description = "Resource Group ID"
  value       = azurerm_resource_group.rg.id
}

output "sa_blob_endpoint" {
  description = "Storage account blob endpoint"
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}

output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.vnet.id
}