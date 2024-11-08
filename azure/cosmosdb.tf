provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "new_rg" {
  name     = "example-resources"
  location = "Brazil South"
}

resource "azurerm_cosmosdb_account" "cosmosaccount" {
  name                = "example-cosmosdb"
  location            = azurerm_resource_group.new_rg.location
  resource_group_name = azurerm_resource_group.new_rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = azurerm_resource_group.new_rg.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableServerless"
  }
}

resource "azurerm_cosmosdb_sql_database" "cosmosdb" {
  name                = "example-db"
  resource_group_name = azurerm_cosmosdb_account.cosmosaccount.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosaccount.name
  throughput          = 400
}

resource "azurerm_cosmosdb_sql_container" "container1" {
  name                = "container1"
  resource_group_name = azurerm_cosmosdb_account.cosmosaccount.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosaccount.name
  database_name       = azurerm_cosmosdb_sql_database.cosmosdb.name
  partition_key_path  = "/myPartitionKey"
  throughput          = 400
}

