resource "azurerm_frontdoor" "frontdoor" {
  name                                         = var.FrontDoor
  resource_group_name                          = var.resource_group
  enforce_backend_pools_certificate_name_check = false

  routing_rule {
    name               = "exampleRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["exampleFrontendEndpoint1"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "exampleBackendBing"
    }
  }

  backend_pool_load_balancing {
    name = "demoLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "demoHealthProbeSetting1"
  }

  backend_pool {
    name = "demoBackendBing"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "demoLoadBalancingSettings1"
    health_probe_name   = "demoHealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "demoFrontendEndpoint1"
    host_name = "demo-FrontDoor.azurefd.net"
  }
}
