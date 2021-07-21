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
    key                  = "virtualmachine.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

variable "ResourceGroup" {
    type = string
    default = "ResourceGroup-1"
}

variable "location" {
    type = string
    default = "West Europe"
}

data "azurerm_network_interface" "NIC1" {
  name                = "networkinterface1"
  resource_group_name = "ResourceGroup-1"
}

data "azurerm_network_interface" "NIC2" {
  name                = "networkinterface2"
  resource_group_name = "ResourceGroup-1"
}

locals {
    size      = "Standard_F2"
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
}

data "terraform_remote_state" "AVSET" {
  backend = "azurerm"

  config = {
    resource_group_name  = "ResourceGroup-1"
    storage_account_name = "terraformstatetest1234"
    container_name       = "terraform"
    key                  = "AVSET.tfstate"
  }
}

resource "azurerm_windows_virtual_machine" "VM1" {
  name                = "VM1"
  resource_group_name = var.ResourceGroup
  location            = var.location
  size                = local.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  availability_set_id = data.terraform_remote_state.AVSET.outputs.avset5
  network_interface_ids = [
    data.azurerm_network_interface.NIC1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = local.version
  }
}

resource "azurerm_windows_virtual_machine" "VM2" {
  name                = "VM2"
  resource_group_name = var.ResourceGroup
  location            = var.location
  size                = local.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  availability_set_id = data.terraform_remote_state.AVSET.outputs.avset5
  network_interface_ids = [
    data.azurerm_network_interface.NIC2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = local.version
  }
}
