virtual_networks = {
  virtual_network1 = {
    name                = "azurelab-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = "nsdrrs"
  }
}

subnet = {
  subnet1 = {
    name             = "app"
    address_prefixes = ["10.0.1.0/24"]
  },
  subnet2 = {
    name             = "db"
    address_prefixes = ["10.0.2.0/24"]
  },
  subnet3 = {
    name             = "vm"
    address_prefixes = ["10.0.3.0/24"]
  }
}

nsg = {
  nsg1 = {
    name = "azurelabnsg"
    security_rule = {
      name                       = "nsg_srg"
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
}


//virtual machine
virtual_network                         = "azurelab-vnet"
subnet_app                              = "app"
subnet_db                               = "db"
location                                = "eastus"
resource_groups                         = ["nsdrrs", "demorg"]
resource_group                          = "nsdrrs"
nsg_name                                = "nsg_demo"
function_app_name                       = "demo-function5566"
storage_account_name                    = "storageaccount8899"
account_tier                            = "Standard"
account_replication_type                = "GRS"
kind                                    = "FunctionApp"
app_service_plan_name                   = "app_service_plan"
azurerm_monitor_diagnostic_setting_name = "demodiag_settings1"
azurerm_monitor_action_group_name       = "az_monitor_group"
azurerm_monitor_metric_alert_name       = "metric_alert"
function_app_storage_account_name       = "fundemostorage7788"
storage_account_account_tier            = "Standard"
storage_account_replication_type        = "GRS"
action_group_name                       = "demo-actiongroup"
group_name                              = "function_alert"
metric_alert_name                       = "vm-metric-alert"
alert_name                              = "function-alert"

//virtual machine
vm_name           = "demo-vm"
vm_admin_username = "azurelabsadmin"
vm_admin_password = "azureP@$$w0rd1234!"
private_ip        = false
/* threshold = "60" */

subnet_delegation = ["Micorosft.Sql/servers"]

application_insights      = "demo-application-insight"
apim_management           = "demoapimmanagement1"
api_management_logger     = "api-log"
application_type          = "web"
verbosity                 = "verbose"
http_correlation_protocol = "W3C"
api_management_api_name   = "demo-api-management"
display_name              = "demo-api"
path                      = "example"

//sql db
sql_server                       = "demo-sqlserver"
sql_version                          = "12.0"
administrator_login              = "4dm1n157r470r"
administrator_login_password     = "4-v3ry-53cr37-p455w0rd"
sql_firewall_rule                = "demo-firewallrule"
server_name                      = "demo-sql"
sql_database                     = "demo-sqldb"
edition                          = "Standard"
requested_service_objective_name = "S0"

//frontdoor

frontdoor_name                   = "example-FrontDoor"
routing_rule_name                = "exampleRoutingRule1"
forwarding_protocol              = "MatchRequest"
backend_pool_name                = "exampleBackendBing"
backend_pool_load_balancing_name = "demoLoadBalancingSettings1"
backend_pool_health_probe_name   = "demoHealthProbeSetting1"
backend_name                     = "demoBackendBing"
load_balancing_name              = "demoLoadBalancingSettings1"
health_probe_name                = "demoHealthProbeSetting1"
frontend_endpoint_name           = "demoFrontendEndpoint1"
host_name                        = "demo-FrontDoor.azurefd.net"

# backend = {
#      name = var.backend_pool_name
#       host  = "www.bing.com"
#       address = "www.bing.com"
#       http_port = "80"
#       https_port ="443"
#     }
#   }
#   frontend  =  {
#     frontend1 = {
#       frontdoor_name = var.frontdoor_name
#       host_name = var.host_name
#     }
#   }
#   routing_rule_name1 = {
#     "routing" = {
#       accepted_protocols = [ "Http","Https" ]
#       frontend_endpoints =["example-FrontDoor"]
#       name = "routing1"
#       patterns_to_match = ["/*"]
#     }