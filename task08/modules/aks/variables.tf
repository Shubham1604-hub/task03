variable "aks_name" {
  description = "The name of the Azure Kubernetes Service (AKS) cluster"
  type        = string
}

variable "aks_node_count" {
  description = "The number of nodes in the AKS cluster"
  type        = number
}

variable "aks_node_pool_name" {
  description = "The name of the default node pool"
  type        = string
}

variable "aks_node_vm_size" {
  description = "The size of the VM for the AKS nodes"
  type        = string
}

variable "aks_dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group where the AKS cluster will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be created"
  type        = string
}

variable "acr_id" {
  description = "The ID of the Azure Container Registry (ACR) to be used by the AKS cluster"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the AKS cluster"
  type        = map(string)
}

variable "os_disk_type" {
  description = "The OS disk type for the AKS nodes (e.g., 'Managed', 'Ephemeral')"
  type        = string
}

variable "os_disk_size_gb" {
  description = "The OS disk size in GB for the AKS nodes"
  type        = number
}

variable "key_vault_id" {
  description = "Key Vault ID"
  type        = string
}
