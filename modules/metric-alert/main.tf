resource "azurerm_monitor_action_group" "acg" {
  name                = var.azurerm_monitor_action_group_name
  resource_group_name = var.resource_group
  short_name          = "demo"

  email_receiver {
    name          = "sendtoadmin"
    email_address = "nsdreddy@outlook.com"
  }
}

resource "azurerm_monitor_metric_alert" "demorule1" {
  name                = var.azurerm_monitor_metric_alert_name
  resource_group_name = var.resource_group
  scopes              = var.scope
  description         = "Action will be triggered when CPU percentage is greater than 60."
  action {
    action_group_id = azurerm_monitor_action_group.acg.id
  }
  dynamic "criteria" {
    for_each = var.criteria
    content {
      metric_namespace = criteria.value.metric_namespace
      metric_name      = criteria.value.metric_name
      aggregation      = criteria.value.aggregation
      operator         = criteria.value.operator
      threshold        = criteria.value.threshold
    }
  }
}
