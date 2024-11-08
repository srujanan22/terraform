resource "azurerm_postgresql_flexible_server" "flexible_server" {
  name                   = "flexibleserver"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = "citus"           
  administrator_password = "Srujana@123"        
  version                = "16"                
   sku_name               = "GP_Standard_D2s_v3"
  storage_mb             = 32768               

  public_network_access_enabled = true
}

resource "azurerm_postgresql_flexible_server_database" "postgracedatabase" {
  name                = "postgracedb"
 server_id = azurerm_postgresql_flexible_server.flexible_server.id
}

