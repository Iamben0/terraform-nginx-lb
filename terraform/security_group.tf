resource "azurerm_network_security_group" "nginx" {
  name                = "nginx-nsg"
  location            = azurerm_resource_group.nginx.location
  resource_group_name = azurerm_resource_group.nginx.name
}

resource "azurerm_network_security_rule" "nginx_access" {
  name                        = "nginx-http-access"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.nginx.name
  network_security_group_name = azurerm_network_security_group.nginx.name
}