resource "azurerm_linux_virtual_machine" "nginx_vm" {
  count               = var.instances
  name                = "nginx-vm-${count.index}"
  resource_group_name = azurerm_resource_group.nginx.name
  location            = azurerm_resource_group.nginx.location
  size                = "Standard_B1s" # Example VM size, choose based on needs
  admin_username      = "azureuser"
  network_interface_ids = [
    element(azurerm_network_interface.nginx[*].id, count.index)
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.ssh_key.public_key_openssh # Use the public key from the tls_private_key resource
  }

  custom_data = filebase64("${path.module}/script/setup_nginx.sh")

  availability_set_id = azurerm_availability_set.nginx.id
}

resource "azurerm_availability_set" "nginx" {
  name                         = "nginx-availability-set"
  location                     = azurerm_resource_group.nginx.location
  resource_group_name          = azurerm_resource_group.nginx.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

resource "azurerm_network_interface" "nginx" {
  count               = var.instances
  name                = "nginx-nic-${count.index}"
  location            = azurerm_resource_group.nginx.location
  resource_group_name = azurerm_resource_group.nginx.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.nginx.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = null
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "nginx" {
  count                   = var.instances
  network_interface_id    = element(azurerm_network_interface.nginx.*.id, count.index)
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.nginx.id
}

# Output the private key for use in the SSH connection to the VM
output "private_ssh_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}
