terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.64.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

locals {
    location      = "EastUS"
    ResourceGroup = "ResourceGroup-1"
    updateDomain  = 6
    faultDomain   = 2
}

resource "azurerm_availability_set" "AVSET1" {
  name                = "AvailabilitySet1"
  location            = local.location
  resource_group_name = local.ResourceGroup

  platform_update_domain_count = local.updateDomain
  platform_fault_domain_count  = local.faultDomain
}

resource "azurerm_availability_set" "AVSET2" {
  name                = "AvailabilitySet2"
  location            = local.location
  resource_group_name = local.ResourceGroup

  platform_update_domain_count = local.updateDomain
  platform_fault_domain_count  = local.faultDomain
}

resource "azurerm_availability_set" "AVSET3" {
  name                = "AvailabilitySet3"
  location            = local.location
  resource_group_name = local.ResourceGroup

  platform_update_domain_count = local.updateDomain
  platform_fault_domain_count  = local.faultDomain
}
