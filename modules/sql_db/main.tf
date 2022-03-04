resource "azurerm_sql_server" "sql_server" {
  name                         = var.sql_server
  resource_group_name          = var.resource_group
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

}

resource "azurerm_sql_firewall_rule" "sql_firewall_rule" {
  name                = var.sql_firewall_rule
  resource_group_name = var.location
  server_name         = var.sql_server
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  name                = "sql-vnet-rule"
  resource_group_name = var.resource_group
  server_name         = var.sql_server
  subnet_id           = var.subnet
}

resource "azurerm_sql_database" "sql_database" {
  name                             = var.sql_database
  resource_group_name              = var.resource_group
  location                         = var.location
  server_name                      = var.sql_server
  edition                          = var.edition
  requested_service_objective_name = var.requested_service_objective_name
}

module "diagnostics" {
  source                     = "../diagnostic_setting"
  name                       = "abcdefggh"
  target_resource_id         = azurerm_sql_database.sql_database.id
  log_analytics_workspace_id = var.log_analytics_id
  retention_policy1 = {
    retention_policy1 = {
      enabled = false
      days    = 30
    }
  }
  logs = {
    log1 = {
      category = "SQLInsights"
      enabled  = true
    }

  }
}

variable "log_analytics_id" {
  type = string
  
}
