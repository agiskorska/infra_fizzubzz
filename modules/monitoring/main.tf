
# TODO test this module

variable "resource_group_name" {
    type    = string
}

variable "environment_name" {
    type    = string
}

variable "app_service_id" {
    type    = string
}
variable "logs_storage_account_id" {
    type    = string
}

data "azurerm_resource_group" "monitoring_rg" {
    name     = var.resource_group_name
}


resource "azurerm_application_insights" "app_insights" {
    name                = "fb-app-insights-${var.environment_name}"
    location            = azurerm_resource_group.monitoring_rg.location
    resource_group_name = azurerm_resource_group.monitoring_rg.name
    application_type    = "web"
}


resource "azurerm_monitor_diagnostic_setting" "app_service_monitoring" {
    name               = "app-service-monitoring"
    target_resource_id = var.app_service_id
    storage_account_id = var.logs_storage_account_id

    log {
        category = "AppServiceConsoleLogs"
        enabled  = true
    }

    log {
        category = "AppServiceHTTPLogs"
        enabled  = true
    }

    metric {
        category = "AllMetrics"
        enabled  = true
    }

    metric {
        category = "Memory"
        enabled  = true
    }

    metric {
        category = "CpuTime"
        enabled  = true
    }

    metric {
        category = "Http4xx"
        enabled  = true
    }

    metric {
        category = "Http5xx"
        enabled  = true
    }
}


output "app_insights_instrumentation_key" {
    value = azurerm_application_insights.app_insights.instrumentation_key
}