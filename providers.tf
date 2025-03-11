terraform {
  required_version = ">= 0.13"  
  required_providers {
    esxi = {
      source = "registry.terraform.io/josenk/esxi"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.17.0"
    }
  }
}

provider "esxi" {
  esxi_hostname = var.esxi.hostname
  esxi_hostport = var.esxi.hostport
  esxi_hostssl  = var.esxi.hostssl
  esxi_username = var.esxi.username
  esxi_password = var.esxi.password
}

provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id = "c064671c-8f74-4fec-b088-b53c568245eb"
  features {

  }
}