output "sql_server_fqdn" {
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
  description = "The fully qualified domain name of the SQL Server"
}

output "sql_database_id" {
  value       = azurerm_mssql_database.sql_database.id
  description = "The ID of the SQL Database"
}


output "sql_connection_string" {
  value = format(
    "Server=tcp:%s,1433;Initial Catalog=%s;Persist Security Info=False;User ID=%s;Password=%s;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
    azurerm_mssql_server.sql_server.fully_qualified_domain_name,
    azurerm_mssql_database.sql_database.name,
    azurerm_mssql_server.sql_server.administrator_login,
    random_password.sql_password.result
  )

  description = "ADO.NET SQL connection string"
  sensitive   = true
}