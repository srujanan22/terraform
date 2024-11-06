resource "azurerm_network_interface" "win_nic" {
  name                = "win-nic"
  location            = azurerm_resource_group.s1_rg.location
  resource_group_name = azurerm_resource_group.s1_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.s1_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "win_vm" {
  name                = "win-vm"
  location            = azurerm_resource_group.s1_rg.location
  resource_group_name = azurerm_resource_group.s1_rg.name
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "YourPasswordHere!"  # Choose a strong password

  network_interface_ids = [azurerm_network_interface.win_nic.id]

  os_disk {
    caching                   = "ReadWrite"
    storage_account_type      = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

