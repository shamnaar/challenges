resource "azurerm_network_security_group" "web-nsg" {
  name                = "web-nsg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
  security_rule {
    name                       = "ssh-rule-1"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }
  security_rule {
    name                       = "httpallow"
    priority                   = 111
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "80"
  }
}

resource "azurerm_subnet_network_security_group_association" "web-nsg-subnet" {
  subnet_id                 = azurerm_subnet.web-subnet.id
  network_security_group_id = azurerm_network_security_group.web-nsg.id
}


resource "azurerm_network_security_group" "db-nsg" {
    name = "db-nsg"
    location = var.location
    resource_group_name = data.azurerm_resource_group.rg.name

    security_rule {
        name = "SQLInbound"
        priority = 101
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "10.0.1.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "3306"
    }
    
    security_rule {
        name = "SQLOutbound"
        priority = 102
        direction = "Outbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "10.0.1.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "3306"
    }
}

resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet" {
  subnet_id                 = azurerm_subnet.db-subnet.id
  network_security_group_id = azurerm_network_security_group.db-nsg.id
}