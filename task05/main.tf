locals {
  common_tags = var.tags

  traffic_manager_endpoints = {
    for k, app in module.app_services : k => {
      name     = app.name
      target   = app.id
      location = var.resource_groups[var.app_services[k].resource_group_key].location
    }
  }
}

module "resource_groups" {
  for_each = var.resource_groups

  source   = "./modules/resource_group"
  name     = each.value.name
  location = each.value.location
  tags     = local.common_tags
}

module "app_service_plans" {
  for_each = var.app_service_plans

  source              = "./modules/app_service_plan"
  name                = each.value.name
  location            = var.resource_groups[each.value.resource_group_key].location
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  sku                 = each.value.sku
  worker_count        = each.value.worker_count
  tags                = local.common_tags

  depends_on = [module.resource_groups]
}

module "app_services" {
  for_each = var.app_services

  source              = "./modules/app_service"
  name                = each.value.name
  location            = var.resource_groups[each.value.resource_group_key].location
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  service_plan_id     = module.app_service_plans[each.value.service_plan_key].id
  ip_restrictions     = var.ip_restrictions
  tags                = local.common_tags

  depends_on = [module.app_service_plans]
}

module "traffic_manager" {
  source = "./modules/traffic_manager"

  name                = var.traffic_manager.name
  resource_group_name = var.resource_groups[var.traffic_manager.resource_group].name
  routing_method      = var.traffic_manager.routing_method
  endpoints           = local.traffic_manager_endpoints
  tags                = local.common_tags

  depends_on = [module.resource_groups, module.app_services]
}