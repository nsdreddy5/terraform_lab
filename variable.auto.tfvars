virtual_networks ={
    virtual_network1 ={
        name = "azurelab-vnet"
        address_space = ["10.0.0.0/16"]
        location = "eastus"
        resource_group_name = "nsdrrs"
    }
}

subnet = {
    subnet1 ={
        name = "app"
        address_prefixes = ["10.0.1.0/24"]
    },
    subnet2 ={
        name = "db"
        address_prefixes = ["10.0.2.0/24"]
    },
    subnet3 ={
        name = "vm"
        address_prefixes = ["10.0.3.0/24"]
    }
}

nsg ={
    nsg1 ={
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



virtual_network = "azurelab-vnet"
subnet_app = "app"
subnet_db = "db"
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
action_group_name                       = "abcefgh"
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

application_insights  = "demo-application-insight"
apim_management       = "demoapimmanagement1"
api_management_logger = "api-log"
application_type = "web"
verbosity ="verbose"
http_correlation_protocol ="W3C"
api_management_api_name = "demo-api-management"
display_name="demo-api"
path="example"
