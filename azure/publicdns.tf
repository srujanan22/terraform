
resource "azurerm_resource_group" "rg" {
  name     = "rg_srujana"
  location = "West US"  
}


resource "azurerm_virtual_network" "test1" {
  name                = "test1-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.1.0/24"]
  location            = azurerm_resource_group.rg.location
}


resource "azurerm_virtual_network" "test2" {
  name                = "test2-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.2.0/24"]
  location            = azurerm_resource_group.rg.location
}


resource "azurerm_virtual_network_peering" "vnet1" {
  name                      = "vnet1-peering"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.test1.name
  remote_virtual_network_id = azurerm_virtual_network.test2.id
}


resource "azurerm_virtual_network_peering" "vnet2" {
  name                      = "vnet2-peering"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.test2.name
  remote_virtual_network_id = azurerm_virtual_network.test1.id
}


resource "azurerm_dns_zone" "public_dns" {
  name                = "example.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_dns_a_record" "www" {
  name                = "www"
  zone_name           = azurerm_dns_zone.public_dns.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = ["10.0.1.4"]
}


resource "azurerm_dns_cname_record" "www_alias" {
  name                = "alias"
  zone_name           = azurerm_dns_zone.public_dns.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  record              = "www.example.com"
}


output "public_dns_zone_name" {
  value = azurerm_dns_zone.public_dns.name
}

