resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

variable "resource_group" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  type = string
}

variable "name" {
  type = string
}

/* variable "source_address_prefix" {
  type        = string
}

variable "destination_address_prefix" {
  type = string
} */

output "nsg" {
  value = azurerm_network_security_group.nsg
}