

module "app_service" {
  for_each = var.environment_info
  source = "./modules/app_service"

  resource_group_name = each.value.resource_group_name
  environment_name = each.key
  
  app_service_plan_name = each.value.resource_group_name
  app_service_name = each.value.resource_group_name
  managed_identity = each.value.managed_identity
}