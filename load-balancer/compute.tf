resource "azurerm_linux_virtual_machine" "main" {
  name                = "vm-demo"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B2als_v2"
  admin_username      = var.admin_username
  disable_password_authentication = true

  network_interface_ids = [azurerm_network_interface.main.id]

  zone = "1"

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub") # Ruta a tu clave pública
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk-demo"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  
  custom_data = base64encode(file("install-nginx.sh"))
}

resource "azurerm_managed_disk" "os_disk" {
  name                 = "osdisk-demo"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 30
  zone                 = "1"
}