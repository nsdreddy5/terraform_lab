resource "azurerm_monitor_diagnostic_setting" "diag_setting" {
  name               = var.name
  target_resource_id = var.target_resource_id

  log_analytics_workspace_id = var.log_analytics_workspace_id


  dynamic "log" {
    for_each = var.logs
    content {
      category = log.value.category
      enabled  = log.value.enabled
      dynamic "retention_policy" {
        /* for_each = (log.value.retention_policy == null ? {} : log.value.retention_policy) */
        for_each = var.retention_policy1
        content {

          enabled = retention_policy.value.enabled
          days    = retention_policy.value.days
        }
      }
    }
  }

}

