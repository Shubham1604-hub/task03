terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "kubectl" {
  host                   = module.aks.aks_cluster_kube_config[0].host
  client_certificate     = base64decode(module.aks.aks_cluster_kube_config[0].client_certificate)
  client_key             = base64decode(module.aks.aks_cluster_kube_config[0].client_key)
  cluster_ca_certificate = base64decode(module.aks.aks_cluster_kube_config[0].cluster_ca_certificate)
}

provider "kubernetes" {
  host                   = module.aks.aks_cluster_kube_config[0].host
  client_certificate     = base64decode(module.aks.aks_cluster_kube_config[0].client_certificate)
  client_key             = base64decode(module.aks.aks_cluster_kube_config[0].client_key)
  cluster_ca_certificate = base64decode(module.aks.aks_cluster_kube_config[0].cluster_ca_certificate)
}