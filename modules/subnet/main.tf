resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_cidr_list

  service_endpoints = var.service_endpoints

  dynamic "delegation" {
    for_each = var.subnet_delegation
    content {
      name = delegation.key
      dynamic "service_delegation" {
        for_each = toset(delegation.value)
        content {
          name    = service_delegation.value.name
          actions = service_delegation.value.actions
        }
      }
    }
  }
  enforce_private_link_endpoint_network_policies = var.enforce_private_link
}

/* resource "azurerm_network_security_group" "nsg" {
  name                = "abcefghhiui"
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
    source_address_prefix      = azurerm_subnet.subnet.address_prefix
    destination_address_prefix = azurerm_subnet.subnet.address_prefix
  }
}

variable "resource_group" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  type = string
} */


/* resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  count = var.network_security_group_name == null ? 0 : 1

  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
} */

/* resource "azurerm_subnet_route_table_association" "route_table_association" {
  count = var.route_table_name == null ? 0 : 1

  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_id

  resource "azurerm_subnet_route_table_association" "route_table_association" {
  subnet_id      = module.appsubnet.subnet.id
  route_table_id = var.route_table_id
}
} */

data "azurerm_subscription" "current" {
}





/* resource "azurerm_subnet" "app-subnet" {

  name                 = var.subnet
  resource_group_name  = var.resource_group
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefix
  service_endpoints    = var.service_endpoints
  delegation {
    name = "example-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "db-subnet" {
  name                 = var.subnet1
  resource_group_name  = var.resource_group
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefix1
  service_endpoints    = var.service_endpoints
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
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
    source_address_prefix      = azurerm_subnet.app-subnet.address_prefix
    destination_address_prefix = azurerm_subnet.db-subnet.address_prefix
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  subnet_id                 = azurerm_subnet.app-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "db-nsg-assocation" {
  subnet_id                 = azurerm_subnet.db-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
} */
