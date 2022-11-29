resource "azurerm_availability_set" "web_availabilty_set" {
  name                = "web_availabilty_set"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "web-net-interface" {
    name = "web-network"
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location

    ip_configuration{
        name = "web-webserver"
        subnet_id = azurerm_subnet.web-subnet.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_virtual_machine" "web-vm" {
  name = "web-vm"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [ azurerm_network_interface.web-net-interface.id ]
  availability_set_id = azurerm_availability_set.web_availabilty_set.id
  vm_size = "Standard_D2s_v3"
  delete_os_disk_on_termination = true
  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name = "web-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = var.web_host_name
    admin_username = var.web_username
    admin_password = var.web_os_password
    custom_data    = file("azure-user-data.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
# Data template Bash bootstrapping file
data "template_file" "linux-vm-cloud-init" {
  template = file("azure-user-data.sh")
}



