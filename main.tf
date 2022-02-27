module "Demo_Azure_Module_RG" {
  source              = "./Modules/Resource_Group"
  resource_group_name = var.resource_group
  location            = var.location
}

module "vnet" {
  depends_on = [
    module.Demo_Azure_Module_RG
  ]
  source         = "./modules/vnet"
  name           = var.name
  address_space  = var.address_space
  resource_group = var.resource_group
  location       = var.location
}

module "subnet" {
  depends_on           = [module.Demo_Azure_Module_RG, module.vnet]
  source               = "./modules/subnet"
  resource_group       = module.vnet.vnet.resource_group_name
  location             = module.vnet.vnet.location
  address_prefix       = var.address_prefix
  address_prefix1      = var.address_prefix1
  subnet               = var.subnet
  subnet1              = var.subnet1
  service_endpoints    = var.service_endpoints
  nsg_name             = var.nsg_name
  virtual_network_name = module.vnet.vnet.name

}

module "storage" {
  depends_on = [
    module.Demo_Azure_Module_RG
  ]
  source                   = "./modules/storage"
  storage_account_name     = var.storage_account_name
  resource_group           = var.resource_group
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

}

module "app_service_plan" {
  depends_on = [
    module.Demo_Azure_Module_RG
  ]
  source                = "./modules/app_service_plan"
  app_service_plan_name = var.app_service_plan_name
  location              = var.location
  resource_group        = var.resource_group
}
module "function_app" {
  depends_on               = [module.Demo_Azure_Module_RG, module.app_service_plan, module.vnet]
  source                   = "./modules/function_app"
  function_app_name        = var.function_app_name
  storage_account_name     = var.function_app_storage_account_name
  location                 = var.location
  resource_group           = var.resource_group
  kind                     = var.kind
  action_group_name        = var.action_group_name
  account_tier             = var.storage_account_account_tier
  account_replication_type = var.storage_account_replication_type
  subnet                   = module.subnet.subnet.id
  /* app_service_plan_name                   = var.app_service_plan_name */
  /* azurerm_monitor_diagnostic_setting_name = var.azurerm_monitor_diagnostic_setting_name */
  azurerm_monitor_action_group_name  = var.azurerm_monitor_action_group_name
  azurerm_monitor_metric_alert_name  = var.azurerm_monitor_metric_alert_name
  storage_account_id                 = module.storage.storage_account.id
  storage_account_primary_access_key = module.storage.storage_account.primary_access_key
  app_service_plan_id                = module.app_service_plan.app_service_plan.id
  # storage_account_name = module.storage.storage_account.name
  alert_name = var.alert_name
}

module "windows_machine" {
  depends_on = [
    module.Demo_Azure_Module_RG
  ]
  source = "./modules/vm"

  location          = var.location
  resource_group    = var.resource_group
  subnet_id         = module.subnet.db_subnet.id
  group_name        = var.group_name
  metric_alert_name = var.metric_alert_name

}

module "diagnostics" {
  depends_on = [
    module.function_app, module.windows_machine
  ]
  source                     = "./modules/diagnostic_setting"
  name                       = "abcd"
  target_resource_id         = module.function_app.function_app.id
  log_analytics_workspace_id = module.function_app.log_analytics.id
  retention_policy1 = {
    retention_policy1 = {
      enabled = false
       days    = 30 
    }
  }
  logs = {
    log1 = {
      category = "FunctionAppLogs"
      enabled = true

      /* retention_policy = { 
        enabled = false
        days    = 30
      
      } */

    }

  }
}









