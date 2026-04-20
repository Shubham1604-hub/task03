locals {
  common_tags = var.tags
}

# Create Resource Groups
module "resource_groups" {
  for_each = var.resource_groups

  source   = "./modules/resource_group"
  name     = each.value.name
  location = each.value.location
  tags     = local.common_tags
}

# Create App Service Plans with explicit dependency on resource groups
module "app_service_plans" {
  for_each = var.app_service_plans

  source              = "./modules/app_service_plan"
  name                = each.value.name
  location            = var.resource_groups[each.key == "asp1" ? "rg1" : "rg2"].location
  resource_group_name = var.resource_groups[each.key == "asp1" ? "rg1" : "rg2"].name
  sku                 = each.value.sku
  worker_count        = each.value.worker_count
  tags                = local.common_tags

  # Add explicit dependency on resource groups
  depends_on = [module.resource_groups]
}

# Create Windows Web Apps with explicit dependency on App Service Plans
module "app_services" {
  for_each = var.app_services

  source              = "./modules/app_service"
  name                = each.value.name
  location            = var.resource_groups[each.value.resource_group_key].location
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  service_plan_id     = module.app_service_plans[each.value.service_plan_key].id
  allow_ip_address    = var.verification_ip
  tags                = local.common_tags

  # Add explicit dependency on App Service Plans
  depends_on = [module.app_service_plans]
}

# Create Traffic Manager endpoints map
locals {
  traffic_manager_endpoints = {
    endpoint1 = {
      name     = module.app_services["app1"].name
      target   = module.app_services["app1"].id
      location = var.resource_groups["rg1"].location
    }
    endpoint2 = {
      name     = module.app_services["app2"].name
      target   = module.app_services["app2"].id
      location = var.resource_groups["rg2"].location
    }
  }
}

# Create Traffic Manager with explicit dependency on resource groups and app services
module "traffic_manager" {
  source = "./modules/traffic_manager"

  name                = var.traffic_manager.name
  resource_group_name = var.resource_groups[var.traffic_manager.resource_group].name
  routing_method      = var.traffic_manager.routing_method
  endpoints           = local.traffic_manager_endpoints
  tags                = local.common_tags

  # Add explicit dependencies on resource groups and app services
  depends_on = [module.resource_groups, module.app_services]
}