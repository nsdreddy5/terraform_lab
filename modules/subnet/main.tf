resource "azurerm_subnet" "subnet" {
 for_each = var.subnet
  name                = each.value["name"]
  resource_group_name  = var.resource_group
  virtual_network_name = var.virtual_network
  address_prefixes     = each.value["address_prefixes"]
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg
  name = each.value["name"]
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = each.value.security_rule.name
    priority                   = each.value.security_rule.priority
    direction                  = each.value.security_rule.direction
    access                     = each.value.security_rule.access
    protocol                   = each.value.security_rule.protocol
    source_port_range          = each.value.security_rule.source_port_range
    destination_port_range     = each.value.security_rule.destination_port_range
    source_address_prefix      = each.value.security_rule.source_address_prefix
    destination_address_prefix = each.value.security_rule.destination_address_prefix

  }
}

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
