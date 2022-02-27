variable "resource_group" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "group_name" {
  type = string
}

variable "metric_alert_name" {
  type = string
}

variable "azurerm_monitor_action_group_name" {
  type    = string
  default = "monitoractiongroup"
}

variable "azurerm_monitor_metric_alert_name" {
  type    = string
  default = "metricrule"
}

/* variable "threshold" {
  type = value
} */