variable "frontdoor_name" {
  type = string
}

variable "routing_rule_name1" {
  type = map(object({
    name = string
   accepted_protocols = list(string)
   frontend_endpoints = list(string)
   patterns_to_match = list(string)
  }))
}

variable "resource_group" {
  type = string
}

variable "backend_pool_name" {
  type = string
}

variable "routing_rule_name" {
  type = string
}

variable "forwarding_protocol" {
  type = string
}
variable "backend_pool_name1" {
  type = map(object({
    name = string
    host = string
    address = string
    http_port = string
    https_port = string
  }))
}

variable "frontend" {
  type = map(object({
    frontdoor_name = string
    host_name = string
  }))
  
}

variable "backend_pool_load_balancing_name" {
  type = string
}
variable "backend_pool_health_probe_name" {
  type = string
}

# variable "backend_name" {
#   type = string
# }

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
