/* resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
} */

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}

/* resource "azurerm_monitor_action_group" "acg" {
  name                = var.azurerm_monitor_action_group_name
  resource_group_name = var.resource_group
  short_name          = "demoag"

  email_receiver {
    name          = "sendtoadmin"
    email_address = "nsdreddy@outlook.com"
  }
}

resource "azurerm_monitor_metric_alert" "demorule1" {
  name                = var.azurerm_monitor_metric_alert_name
  resource_group_name = var.resource_group
  scopes              = [azurerm_windows_virtual_machine.example.id]
  description         = "Action will be triggered when CPU percentage is greater than 60."

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 60
  }

  action {
    action_group_id = azurerm_monitor_action_group.acg.id
  }
} */

module "metric_alert" {
  source                            = "../metric-alert"
  azurerm_monitor_action_group_name = var.group_name
  resource_group                    = var.resource_group
  azurerm_monitor_metric_alert_name = var.metric_alert_name
  scope                             = [azurerm_windows_virtual_machine.example.id]
  criteria = {
    criteria1 = {
      metric_namespace = "Microsoft.Compute/virtualMachines"
      metric_name      = "Percentage CPU"
      aggregation      = "Average"
      operator         = "GreaterThan"
      threshold        = 60
    }
  }

  /* action_group_id = azurerm_monitor_action_group.acg.id */
}



resource "azurerm_virtual_machine_extension" "vmantivirus" {
  name                       = "vmantivirus"
  virtual_machine_id         = azurerm_windows_virtual_machine.example.id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = "true"

  settings = <<SETTINGS
{
"AntimalwareEnabled": true,
"RealtimeProtectionEnabled": "true",
"ScheduledScanSettings": {
"isEnabled": "true",
"day": "1",
"time": "120",
"scanType": "Quick"
},
"Exclusions": {
"Extensions": "",
"Paths": "",
"Processes": ""
}
}
SETTINGS

  /* tags {
environment = "lab" 
} */
}