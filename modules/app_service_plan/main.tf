resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group

  sku {
    tier = "Standard"
    size = "S1"
  }
}

/* 
module "diagnostics" {
  source                     = "../diagnostic_setting"
  name                       = "abcdefggh"
  target_resource_id         = azurerm_app_service_plan.app_service_plan.id
  log_analytics_workspace_id = var.log_analytics_id
  retention_policy1 = {
    retention_policy1 = {
      enabled = false
      days    = 30
    }
  }
  logs = {
    log1 = {
      category = "NetworkSecurityGroupEvent"
      enabled  = true
    }

  }
}

variable "log_analytics_id" {
  type = string
   */
}