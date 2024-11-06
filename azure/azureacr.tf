resource "azurerm_resource_group" "rg" {
  name     = "rg_srujana1"
  location = "East US"
}

resource "azurerm_container_registry" "acr" {
  name                     = "s11acr" 
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  sku                       = "Basic" 
  admin_enabled            = true  

  tags = {
    environment = "development"
  }
}

output "acr_url" {
  value = azurerm_container_registry.acr.login_server



