resource "azurerm_lb" "nginx" {
  name                = "nginx-lb"
  location            = azurerm_resource_group.nginx.location
  resource_group_name = azurerm_resource_group.nginx.name

  frontend_ip_configuration {
    name                 = "public-ip-config"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "nginx" {
  name            = "nginx-backend"
  loadbalancer_id = azurerm_lb.nginx.id
}

resource "azurerm_lb_rule" "http" {
  resource_group_name            = azurerm_resource_group.nginx.name
  loadbalancer_id                = azurerm_lb.nginx.id
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "public-ip-config"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.nginx.id]
  idle_timeout_in_minutes        = 4
  enable_floating_ip             = false
}
