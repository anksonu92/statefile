terraform {
  required_version = "~> 1.1"
  required_providers {
    azuread = {
      source  = "registry.terraform.io/hashicorp/azuread"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "registry.terraform.io/hashicorp/azurerm"
      version = "~> 3.9"
    }
    random = {
      source  = "registry.terraform.io/hashicorp/random"
      version = "~> 3.0"
    }
    time = {
      source  = "registry.terraform.io/hashicorp/time"
      version = "~> 0.7"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  skip_provider_registration = false
  storage_use_azuread        = true # prereq to using 'rbac' access model!
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = false
    }
  }
}

data "azuread_domains" "lens" {
  only_default = true
}




resource "azurerm_resource_group" "lens" {
  location = "eastus2"
  name     = "lens-storage"
}

module "lens_storage_account" {
  source = "../../../"

  resource_group_name = azurerm_resource_group.lens.name
  location            = azurerm_resource_group.lens.location

}


output "storage_account" {
  value = module.lens_storage_account.storage_account
}

