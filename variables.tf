variable "name" {
  type = string
  /* default = "myvnet" */
}

variable "address_space" {
  type = list(string)
  /* default = ["10.0.0.0/16"] */
}

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
variable "subnet" {
  type = string
  /* default = "subnet" */
}

variable "subnet1" {
  type = string
  /* default = "subnet1" */
}

variable "address_prefix" {
  type = list(string)
  /* default = ["10.0.1.0/24"] */
}

variable "address_prefix1" {
  type = list(string)
  /* default = ["10.0.2.0/24"] */
}

variable "service_endpoints" {
  type = list(string)
  /* default = ["Microsoft.keyvault"] */
}

variable "subnet_delegation" {
  type = list(string)
  /* default = ["Microsoft.keyvault"] */
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


/* variable "threshold" {
  type = value
} */


# variable "storage_account_primary_access_key" {
#   type    = string
#   default = null
# }

/* variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "acctvnet"
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

# If no values specified, this defaults to Azure DNS
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
  default     = ["subnet1", "subnet2", "subnet3"]
}

variable "subnet_service_endpoints" {
  description = "A map of subnet name to service endpoints to add to the subnet."
  type        = map(any)
  default     = {}
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "A map of subnet name to enable/disable private link endpoint network policies on the subnet."
  type        = map(bool)
  default     = {}
}

variable "subnet_enforce_private_link_service_network_policies" {
  description = "A map of subnet name to enable/disable private link service network policies on the subnet."
  type        = map(bool)
  default     = {}
}

variable "subnet_delegation" {
  description = "A map of subnet name to delegation block on the subnet"
  type        = map(map(any))
  default     = {}
}

variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)

  default = {
  }
}

variable "route_tables_ids" {
  description = "A map of subnet name to Route table ids"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ENV = "test"
  }
}

variable "vnet_location" {
  description = "The location of the vnet to create. Defaults to the location of the resource group."
  type        = string
  default     = null
} */
