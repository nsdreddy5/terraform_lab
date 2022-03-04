variable "resource_group" {
  type = string
}

variable "location" {
  type = string
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
variable "subnet" {
  type = string
}