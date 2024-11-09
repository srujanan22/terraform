provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_srujana" {
  name     = "rg_srujana"
  location = "UAE Central"
}

resource "azurerm_mysql_flexible_server" "mysqldbnew1" {
  name                   = "mysqldb-flexible-server"
  resource_group_name    = azurerm_resource_group.rg_srujana.name
  location               = azurerm_resource_group.rg_srujana.location
  administrator_login    = "srujana"
  administrator_password = "Srujana@123"
  sku_name               = "B_Standard_B1s"
}

resource "azurerm_mysql_flexible_database" "mysqldbnew" {
  name                = "mysqldb"
  resource_group_name = azurerm_resource_group.rg_srujana.name
  server_name         = azurerm_mysql_flexible_server.mysqldbnew1.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}



