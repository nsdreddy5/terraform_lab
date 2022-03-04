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

module "diagnostics" {
  source                     = "../diagnostic_setting"
  name                       = "abcdefggh"
  target_resource_id         = azurerm_network_security_group.nsg.id
  log_analytics_workspace_id = var.log_analytics_id
  retention_policy1 = {
    retention_policy1 = {
      enabled = false
      days    = 30
    }
  }
  logs = {
    log1 = {
      category = "NetworkSecurityGroupEvent"
      enabled  = true
    }

  }
}

variable "log_analytics_id" {
  type = string
  
}



  /* priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*" */