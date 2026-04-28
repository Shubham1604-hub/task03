variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
}

variable "acr_sku" {
  description = "ACR SKU"
  type        = string
}

variable "image_name" {
  description = "name of the image"
  type        = string
}

variable "tags" {
  description = "Tags for the Azure Container Registry"
  type        = map(string)
}


variable "repo_url" {
  description = "The URL of the Git repository containing the Dockerfile"
  type        = string
}

variable "git_pat" {
  description = "The Personal Access Token (PAT) for accessing the Git repository"
  type        = string
  sensitive   = true
}

