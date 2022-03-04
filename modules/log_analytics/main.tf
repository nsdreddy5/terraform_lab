resource "azurerm_log_analytics_workspace" "demologaws" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
}



