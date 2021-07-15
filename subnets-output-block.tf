terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.64.0"
    }
  }
   backend "azurerm" {
    resource_group_name  = "ResourceGroup-1"
    storage_account_name = "terraformstatetest1234"
    container_name       = "terraform"
    key                  = "subnet.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

output "ProdSubnet" {
    description = "This is prod subnet ID"
    value = azurerm_subnet.subnet1.id
}

output "DevSubnet" {
    description = "This is Dev subnet ID"
    value = azurerm_subnet.subnet2.id
}

resource "azurerm_subnet" "subnet1" {
  name                 = "Prod"
  resource_group_name  = var.RGName
  virtual_network_name = var.VNETName
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "Dev"
  resource_group_name  = var.RGName
  virtual_network_name = var.VNETName
  address_prefixes     = ["10.0.2.0/24"]
}
