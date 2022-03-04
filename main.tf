module "Demo_Azure_Module_RG" {
  source          = "./Modules/Resource_Group"
  resource_groups = var.resource_groups
  location        = var.location
}
/* module "log_analytics" {
  source = "./Modules/log_analytics"
  depends_on = [
    module.Demo_Azure_Module_RG
  ]
  resource_group_name = var.resource_group
  location            = var.location
} */

module "la" {
  depends_on = [
    module.Demo_Azure_Module_RG
  ]
  source = "./modules/log_analytics"
  resource_group = var.resource_group
  log_analytics_name = "eus-la"
  location = var.location
  sku = "PerGB2018"
  retention_in_days = 30
}

locals {
  network_security_group_names = ["nsg1", "nsg2"]
  subnetname                   = ["appsubnet", "dbsubnet"]
  cidr                         = ["10.0.1.0/24", "10.0.2.0/24"]

  /* vnet_cidr = "10.0.1.0/24" */

  subnets = [
    {
      name              = "subnet1"
      cidr              = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Web"]
      /* nsg_name          = local.network_security_group_names[0] */
      /* vnet_name         = module.azure-network-vnet.virtual_network_name */

    },
    {
      name              = "subnet2"
      cidr              = ["10.0.2.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Web"]
      /* nsg_name          = local.network_security_group_names[2]
      vnet_name         = module.azure-network-vnet.virtual_network_name */
    }
  ]
}

output "azurerm_subnet" {
  value = module.subnet.subnet.*
}
module "vnet" {
  depends_on = [module.Demo_Azure_Module_RG,module.l]
  source           = "./modules/vnet"
  virtual_networks = var.virtual_networks
  log_analytics_id = module.la.log_analytics.id

}

module "subnet" {
  depends_on      = [module.vnet]
  source          = "./modules/subnet"
  subnet          = var.subnet
  resource_group  = var.resource_group
  location        = var.location
  nsg             = var.nsg
  virtual_network = var.virtual_network

}
module "storage" {
  depends_on = [module.Demo_Azure_Module_RG]
  source                   = "./modules/storage"
  storage_account_name     = var.storage_account_name
  resource_group           = var.resource_group
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

}

module "app_service_plan" {
  depends_on = [module.Demo_Azure_Module_RG]
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
  subnet                   = module.subnet.subnet.subnet1.id
  /* azurerm_monitor_diagnostic_setting_name = var.azurerm_monitor_diagnostic_setting_name */
  azurerm_monitor_action_group_name  = var.azurerm_monitor_action_group_name
  azurerm_monitor_metric_alert_name  = var.azurerm_monitor_metric_alert_name
  storage_account_id                 = module.storage.storage_account.id
  storage_account_primary_access_key = module.storage.storage_account.primary_access_key
  app_service_plan_id                = module.app_service_plan.app_service_plan.id
  # storage_account_name = module.storage.storage_account.name
  alert_name = var.alert_name
}

//Windows VM Creation
module "windows_machine" {
  depends_on = [module.Demo_Azure_Module_RG]
  source = "./modules/vm"
  location          = var.location
  resource_group    = var.resource_group
  subnet_id         = module.subnet.subnet.subnet3.id
  group_name        = var.group_name
  metric_alert_name = var.metric_alert_name
  vm_name           = var.vm_name
  vm_admin_username = var.vm_admin_username
  vm_admin_password = var.vm_admin_password
  private_ip        = var.private_ip

}



//Diagnostics Settings
module "diagnostics" {
  depends_on = [module.function_app, module.windows_machine, module.Demo_Azure_Module_RG]
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
      enabled  = true
    }

  }
}

//SQL DB Creation
module "sql_db" {
  depends_on = [module.Demo_Azure_Module_RG,module.la]
  source                           = "./modules/sql_db"
  resource_group                   = var.resource_group
  location                         = var.location
  sql_server                       = var.sql_server
  sql_version                      = var.sql_version
  subnet                           = module.subnet.subnet.subnet2.id
  administrator_login              = var.administrator_login
  administrator_login_password     = var.administrator_login_password
  sql_firewall_rule                = var.sql_firewall_rule
  sql_database                     = var.sql_database
  edition                          = var.edition
  requested_service_objective_name = var.requested_service_objective_name
  log_analytics_id = module.la.log_analytics.id
}


//log-analytics


//frontdoor
module "frontdoor" {
  depends_on                       = [module.Demo_Azure_Module_RG]
  source                           = "./modules/Frontdoor"
  frontdoor_name                   = var.frontdoor_name
  resource_group                   = var.resource_group
  routing_rule_name                = var.routing_rule_name
  forwarding_protocol              = var.forwarding_protocol
  backend_pool_name                = var.backend_pool_name
  backend_pool_load_balancing_name = var.backend_pool_load_balancing_name
  backend_pool_health_probe_name   = var.backend_pool_health_probe_name
  backend_pool_name1 = {
    backend = {
     name = var.backend_pool_name
      host  = "www.bing.com"
      address = "www.bing.com"
      http_port = "80"
      https_port ="443"
    }
  }
  frontend  =  {
    frontend1 = {
      frontdoor_name = var.frontdoor_name
      host_name = var.host_name
    }
  }
  routing_rule_name1 = {
    "routing" = {
      accepted_protocols = [ "Http","Https" ]
      frontend_endpoints =["example-FrontDoor"]
      name = "routing1"
      patterns_to_match = ["/*"]
    }
  }
  load_balancing_name              = var.load_balancing_name
  health_probe_name                = var.health_probe_name
  frontend_endpoint_name           = var.frontend_endpoint_name
  host_name                        = var.host_name
}
//NSG
/* module "nsg" {
  depends_on     = [module.Demo_Azure_Module_RG, module.dbsubnet, module.la,module.appsubnet]
  source         = "./modules/nsg"
  name           = "nsg-rule"
  location       = var.location
  resource_group = var.resource_group */
/* source_address_prefix =  module.appsubnet.subnet.id
  destination_address_prefix =  module.dbsubnet.subnet.id
  log_analytics_id = module.la.log_analytics.id
   */
/* } */


//NSG association
/* resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  subnet_id                 = module.appsubnet.subnet.id
  network_security_group_id = module.nsg.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "dbsubnet_association" {
  subnet_id                 = module.dbsubnet.subnet.id
  network_security_group_id = module.nsg.nsg.id
}

//module apim
module "apim" {
  depends_on            = [module.Demo_Azure_Module_RG] 
  source                = "./modules/apim"
  location              =  var.location
  resource_group        = var.resource_group
  application_insights  = var.application_insights
  apim_management       = var.apim_management
  api_management_logger = var.api_management_logger
  application_type = var.application_type
verbosity = var.verbosity
http_correlation_protocol=var.http_correlation_protocol
api_management_api_name=var.api_management_api_name
display_name=var.display_name
path=var.path
/* } */ 