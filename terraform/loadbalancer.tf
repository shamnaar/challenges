resource "azurerm_public_ip" "publicip" {
  name                = "PublicIPForLB"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = "test-lb"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                          = "PublicIPAddress"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bepool" {
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "BackEndAddressPool"
}

resource "azurerm_network_interface" "nic" {
  name                = "test-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration"
    subnet_id                     = azurerm_subnet.web-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "backend" {
  network_interface_id    = azurerm_network_interface.nic.id
  ip_configuration_name   = "testconfiguration"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
}
resource "azurerm_lb_probe" "probe" {
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "http-probe"
  protocol            = "Http"
  request_path        = "/"
  port                = 80
}
resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [ azurerm_lb_backend_address_pool.bepool.id ]
  probe_id                       = azurerm_lb_probe.probe.id
}


