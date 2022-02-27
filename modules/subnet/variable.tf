variable "location" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "subnet" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "subnet1" {
  type = string
}

variable "address_prefix" {
  type = list(string)
}

variable "address_prefix1" {
  type = list(string)
}
variable "service_endpoints" {
  type = list(string)
}

variable "nsg_name" {
  type = string
}