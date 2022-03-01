resource "azurerm_public_ip" "demo_ip" {
  name                = "demo_ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"


}

output "public_ip" {
  value = azurerm_public_ip.demo_ip
}
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip == false ? "static" : "Dynamic"

    private_ip_address = var.private_ip == false ? azurerm_public_ip.demo_ip.ip_address : null

    public_ip_address_id = var.private_ip == false ? azurerm_public_ip.demo_ip.id : null

  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_F2"
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
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
}