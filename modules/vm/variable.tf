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