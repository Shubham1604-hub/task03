output "sql_server_fqdn" {
  value       = module.sql.sql_server_fqdn
  description = "The fully qualified domain name of the SQL Server"
}

output "app_hostname" {
  value       = module.webapp.app_hostname
  description = "The hostname of the Web App"
}