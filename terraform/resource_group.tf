resource "azurerm_resource_group" "nginx" {
  name     = "nginx-resources"
  location = "East US"
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}