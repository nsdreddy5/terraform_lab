output "metric_alert" {
  value = azurerm_monitor_metric_alert.demorule1
}

output "action_group" {
  value = azurerm_monitor_action_group.acg
}