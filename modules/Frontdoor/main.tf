resource "azurerm_frontdoor" "frontdoor" {
  name                                         = var.frontdoor_name
  resource_group_name                          = var.resource_group
  enforce_backend_pools_certificate_name_check = false

  dynamic "routing_rule" {
    for_each = var.routing_rule_name1
    content {
    name               = routing_rule.value.name
    accepted_protocols = routing_rule.value.accepted_protocols
    patterns_to_match  = routing_rule.value.patterns_to_match
    frontend_endpoints = routing_rule.value.frontend_endpoints
    forwarding_configuration {
      forwarding_protocol = var.forwarding_protocol
      backend_pool_name   = var.backend_pool_name
    }
  }
  }

  backend_pool_load_balancing {
    name = var.backend_pool_load_balancing_name
  }

  backend_pool_health_probe {
    name = var.backend_pool_health_probe_name
  }

  dynamic "backend_pool" { 
    for_each = var.backend_pool_name1
    content {
    name = backend_pool.value.name
    backend {
      host_header = backend_pool.value.host
      address     = backend_pool.value.address
      http_port   =  backend_pool.value.http_port
      https_port  =  backend_pool.value.https_port
    }
    
    load_balancing_name = var.backend_pool_load_balancing_name
    health_probe_name   = var.backend_pool_health_probe_name
  }
  }

 dynamic "frontend_endpoint" {
   for_each =  var.frontend
   content{
    name      = frontend_endpoint.value.frontdoor_name
    host_name = frontend_endpoint.value.host_name
  }
}
}
output "frontdoor" {
  value = azurerm_frontdoor.frontdoor
}
