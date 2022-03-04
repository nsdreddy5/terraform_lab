variable "location" {
  type = string
  /* default = "eastus" */
}

variable "resource_group" {
  type = string
  /* default = "nsdrrs" */
}
variable "resource_groups" {
  type = list(string)
  /* default = "nsdrrs" */
}

variable "action_group_name" {
  type = string
}

variable "group_name" {
  type = string
}

variable "metric_alert_name" {
  type = string
}

variable "alert_name" {
  type = string
}

variable "app_service_plan_name" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "function_app_storage_account_name" {
  type = string
}

variable "storage_account_account_tier" {
  type = string
}

variable "storage_account_replication_type" {
  type = string
}


variable "kind" {
  type = string
}

variable "function_app_name" {
  type = string
}

variable "azurerm_monitor_diagnostic_setting_name" {
  type = string
}

variable "azurerm_monitor_action_group_name" {
  type = string
}

variable "azurerm_monitor_metric_alert_name" {
  type = string
}

variable "private_ip" {
  type    = bool
  default = true
}

variable "vm_name" {
  type    = string
  default = "windows_vm"
}

variable "vm_admin_username" {
  type    = string
  default = "admin"
}

variable "vm_admin_password" {
  type    = string
  default = "P@$$w0rd1234!"
}

variable "application_insights" {
  type = string
}

variable "apim_management" {
  type = string
}

variable "api_management_logger" {
  type = string
}

variable "application_type" {
  type = string
}

variable "verbosity" {
  type = string
}

variable "http_correlation_protocol" {
  type = string
}


variable "api_management_api_name" {
  type = string
}

variable "display_name" {
  type = string
}

variable "path" {
  type = string
}

variable "virtual_networks" {
  type = map(object({
    name                = string
    address_space       = list(string)
    location            = string
    resource_group_name = string
  }))
  default = {}

}

variable "virtual_network" {
  type = string
}

variable "subnet" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = {}

}
variable "nsg" {
  type = any
}
variable "sql_server" {
  type = string
}
variable "sql_firewall_rule" {
  type = string
}

variable "sql_version" {
  type = string
}

variable "administrator_login" {
  type = string
}
variable "administrator_login_password" {
  type = string
}
variable "sql_database" {
  type = string
}

variable "edition" {
  type = string
}
variable "requested_service_objective_name" {
  type = string
}


variable "frontdoor_name" {
  type = string
}





variable "routing_rule_name" {
  type = string
}

variable "forwarding_protocol" {
  type = string
}
variable "backend_pool_name" {
  type = string
}
variable "backend_pool_load_balancing_name" {
  type = string
}
variable "backend_pool_health_probe_name" {
  type = string
}

variable "backend_name" {
  type = string
}

variable "load_balancing_name" {
  type = string
}
variable "health_probe_name" {
  type = string
}
variable "frontend_endpoint_name" {
  type = string
}

variable "host_name" {
  type = string
}
