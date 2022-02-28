variable "azurerm_monitor_action_group_name" {
  type = string
}

variable "azurerm_monitor_metric_alert_name" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "scope" {
  type = list(string)
}
variable "criteria" {
  type = map(object({
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
  }))
}