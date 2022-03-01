variable "subnet" {
  type = map(object({
    name = string
    address_prefixes = list(string)
 }))
default = {}

}
variable "resource_group" {
  description = "Resource group name"
  type        = string
}

variable "virtual_network" {
  description = "Virtual network name"
  type        = string
}

variable "location" {
  type = string
}

variable "nsg" {
  type = any
}
