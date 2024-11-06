provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "s1_rg" {
  name     = "s1-resource-group"
  location = "West US 2"
}

resource "azurerm_virtual_network" "s1_vnet" {
  name                = "s1-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.s1_rg.location
  resource_group_name = azurerm_resource_group.s1_rg.name
}

resource "azurerm_subnet" "s1_subnet" {
  name                 = "s1-subnet"
  resource_group_name  = azurerm_resource_group.s1_rg.name
  virtual_network_name = azurerm_virtual_network.s1_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}  # Closing brace added here

resource "azurerm_network_interface" "s1_nic" {
  name                = "s1-nic"
  location            = azurerm_resource_group.s1_rg.location
  resource_group_name = azurerm_resource_group.s1_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.s1_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "s1_vm" {
  name                = "s1-vm"
  location            = azurerm_resource_group.s1_rg.location
  resource_group_name = azurerm_resource_group.s1_rg.name
  size                = "Standard_B1s" 
  admin_username      = "adminuser" 

  admin_ssh_key {
    username   = "adminuser"   
    public_key = file("~/.ssh/my_ssh_key.pub")  
  }

  network_interface_ids = [azurerm_network_interface.s1_nic.id]

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
}

output "public_ip_address" {
  value = azurerm_network_interface.s1_nic.ip_configuration[0].private_ip_address
}

