module "Demo_Azure_Module_RG" {
  source          = "./Modules/Resource_Group"
  resource_groups = var.resource_groups
  location        = var.location
}
module "log_analytics" {
  source              = "./Modules/log_analytics"
  resource_group_name = var.resource_group
  location            = var.location
}
locals {
  network_security_group_names = ["nsg1", "nsg2"]
  subnetname                   = ["appsubnet", "dbsubnet"]
  cidr                         = ["10.0.1.0/24", "10.0.2.0/24"]

  /* vnet_cidr = "10.0.1.0/24" */

  subnets = [
    {
      name              = "diwakar"
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


module "vnet" {
  depends_on = [
    module.Demo_Azure_Module_RG
  ]
  source         = "./modules/vnet"
  name           = var.name
  address_space  = var.address_space
  resource_group = var.resource_group
  location       = var.location
  /* log_analytics_workspace_id = module.Demo_Azure_Module_RG.log_analytics.id */
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
  /* subnet                   = module.subnet.subnet.id */
  subnet = module.appsubnet.subnet.id
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
  subnet_id         = module.dbsubnet.subnet.id
  group_name        = var.group_name
  metric_alert_name = var.metric_alert_name
  vm_name           = var.vm_name
  vm_admin_username = var.vm_admin_username
  vm_admin_password = var.vm_admin_password
  private_ip        = var.private_ip

}

module "diagnostics" {
  depends_on = [
    module.function_app, module.windows_machine, module.Demo_Azure_Module_RG
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
      enabled  = true

      /* retention_policy = { 
        enabled = false
        days    = 30
      
      } */

    }

  }
}


module "appsubnet" {
  depends_on = [
    module.Demo_Azure_Module_RG, module.vnet
  ]
  source               = "./modules/subnet"
  subnet_name          = local.subnetname[0]
  resource_group       = module.vnet.vnet.resource_group_name
  location             = module.vnet.vnet.location
  virtual_network_name = module.vnet.vnet.name
  subnet_cidr_list     = var.address_prefix
  service_endpoints    = var.service_endpoints

  subnet_delegation = {
    app-service-plan = [
      {
        name    = "Microsoft.Web/serverFarms"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    ]
  }
}

output "subnet" {
  value = module.appsubnet.subnet
}



module "dbsubnet" {
  depends_on = [
    module.Demo_Azure_Module_RG, module.vnet
  ]
  source               = "./modules/subnet"
  subnet_name          = local.subnetname[1]
  resource_group       = module.vnet.vnet.resource_group_name
  location             = module.vnet.vnet.location
  virtual_network_name = module.vnet.vnet.name
  subnet_cidr_list     = var.address_prefix1
  service_endpoints    = var.service_endpoints

  subnet_delegation = {
    app-service-plan = [
      {
        name    = "Microsoft.Web/serverFarms"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    ]
  }
}

output "dbsubnet" {
  value = module.dbsubnet.subnet
}


//NSG
module "nsg" {
  depends_on     = [module.Demo_Azure_Module_RG, module.dbsubnet, module.appsubnet]
  source         = "./modules/nsg"
  name           = "nsg-rule"
  location       = var.location
  resource_group = var.resource_group
  /* source_address_prefix =  module.appsubnet.subnet.id
  destination_address_prefix =  module.dbsubnet.subnet.id */
}


//NSG association
resource "azurerm_subnet_network_security_group_association" "subnet_association" {
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
}