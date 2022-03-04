resource "azurerm_virtual_network" "vnet" {
  for_each            = var.virtual_networks
  name                = each.value["name"]
  address_space       = each.value["address_space"]
  location            = each.value["location"]
  resource_group_name = each.value["resource_group_name"]
}

module "diagnostics" {
  source                     = "../diagnostic_setting"
  name                       = "abcdefg"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = var.log_analytics_id
  retention_policy1 = {
    retention_policy1 = {
      enabled = false
      days    = 30
    }
  }
  logs = {
    log1 = {
      category = "VMProtectionAlerts"
      enabled  = true
    }

  }
}

variable "log_analytics_id" {
  type = string
  
}

