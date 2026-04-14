terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" # ✅ FIXED
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}