resource "azurerm_mssql_server" "sqlserver" {
    name = "primary-sqlserver"
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    version = "12.0"
    administrator_login = var.database_admin
    administrator_login_password = var.database_password
}

resource "azurerm_mssql_database" "db" {
  name                = "test-db"
  server_id           = azurerm_mssql_server.sqlserver.id
}