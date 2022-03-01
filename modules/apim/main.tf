resource "azurerm_application_insights" "application_insights" {
  name                = var.application_insights
  location            = var.location
  resource_group_name = var.resource_group
  application_type    = var.application_type
}


resource "azurerm_api_management" "apim" {
  name                = var.apim_management
  location            = var.location
  resource_group_name = var.resource_group
  publisher_name      = "My Company"
  publisher_email     = "company@terraform.io"
  sku_name            = "Developer_1"
} 


/* resource "azurerm_api_management_api" "api_management" {
  name                = var.api_management_api_name
  resource_group_name = var.resource_group
  api_management_name = azurerm_api_management.apim_management.name
  revision            = "1"
  display_name        = var.display_name
  path                = var.path
  protocols           = ["https"]

  import {
    content_format = "swagger-link-json"
    content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
  }
}

 resource "azurerm_api_management_logger" "api_management_logger" {
  name                = var.api_management_logger
  api_management_name = var.apim_management
  resource_group_name = var.resource_group

  application_insights {
    instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  }
} 


resource "azurerm_api_management_diagnostic" "example" {
  identifier               = "applicationinsights"
  resource_group_name      = var.resource_group
  api_management_name      = var.apim_management
  api_management_logger_id = azurerm_api_management_logger.api_management_logger.id

  sampling_percentage       = 5.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = var.verbosity
  http_correlation_protocol = var.http_correlation_protocol

  frontend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  frontend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }

  backend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  backend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }
}  */
