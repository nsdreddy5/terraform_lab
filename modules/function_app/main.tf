resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_function_app" "functionapp" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  site_config {
    dotnet_framework_version = "v6.0"
  }
  version = "~3"
}

resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = var.app_service_plan_id
  subnet_id      = var.subnet
}

output "function_app" {
  value = azurerm_function_app.functionapp
}

resource "azurerm_log_analytics_workspace" "demologaws" {
  name                = "acctest-01"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

output "log_analytics" {
  value = azurerm_log_analytics_workspace.demologaws
}


module "metric_alert" {
  source                            = "../metric-alert"
  azurerm_monitor_action_group_name = var.action_group_name
  resource_group                    = var.resource_group
  azurerm_monitor_metric_alert_name = var.alert_name
  scope                             = [var.app_service_plan_id]
  criteria = {
    criteria1 = {
      metric_namespace = var.metric_namespace
      metric_name      = "CpuPercentage"
      aggregation      = "Average"
      operator         = "GreaterThan"
      threshold        = 60
    }
  }

  /* action_group_id = azurerm_monitor_action_group.acg.id */
}





