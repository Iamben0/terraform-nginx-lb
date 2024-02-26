data "external" "fetch_cidr" {
  program = ["bash", "${path.module}/script/fetch_cidr.sh"]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "nginx-vnet"
  address_space       = ["${data.external.fetch_cidr.result.ip_address}/${data.external.fetch_cidr.result.subnet_size}"]
  location            = azurerm_resource_group.nginx.location
  resource_group_name = azurerm_resource_group.nginx.name
}

resource "azurerm_subnet" "nginx" {
  name                 = "nginx-subnet"
  resource_group_name  = azurerm_resource_group.nginx.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${data.external.fetch_cidr.result.ip_address}/24"]
}
