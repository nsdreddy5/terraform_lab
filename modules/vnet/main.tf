resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group
}



/* module "diagnostics" {
  depends_on = [
    module.function_app, module.windows_machine
  ]
  source                     = "./modules/diagnostic_setting"
  name                       = "abcd"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  retention_policy1 = {
    retention_policy1 = {
      enabled = false
       days    = 30 
    }
  }
  logs = {
    log1 = {
      category = "FunctionAppLogs"
      enabled = true

    }

  }
} */
/* resource "azurerm_log_analytics_workspace" "demologaws" {
  name                = "acctest-02"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

output "log_analytics" {
  value = azurerm_log_analytics_workspace.demologaws
} */
