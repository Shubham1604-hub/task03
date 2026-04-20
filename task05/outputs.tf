output "traffic_manager_fqdn" {
  description = "Azure Traffic Manager FQDN"
  value       = module.traffic_manager.fqdn
}

output "resource_group_details" {
  description = "Details of all resource groups"
  value = {
    for k, rg in module.resource_groups : k => {
      name     = rg.name
      location = rg.location
    }
  }
}

output "app_service_details" {
  description = "Details of all App Services"
  value = {
    for k, app in module.app_services : k => {
      name             = app.name
      default_hostname = app.default_hostname
    }
  }
}

output "traffic_manager_endpoints" {
  description = "Traffic Manager endpoints"
  value = {
    for k, endpoint in local.traffic_manager_endpoints : k => {
      name     = endpoint.name
      location = endpoint.location
    }
  }
}