variable "environment_info" {
  description = "A map of environment information."
  type        = map(object({
    resource_group_name = string
    app_service_plan_name    = string
    app_service_name    = string
    managed_identity = string
  }))
}

