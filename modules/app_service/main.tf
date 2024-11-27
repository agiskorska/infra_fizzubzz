
data "azurerm_resource_group" "current" {
  name     = var.resource_group_name
}

data "azurerm_user_assigned_identity" "current" {
  name                = var.managed_identity
  resource_group_name = var.resource_group_name
}

resource "azurerm_app_service_plan" "current" {
  name                = var.app_service_plan_name
  location            = data.azurerm_resource_group.current.location
  resource_group_name = data.azurerm_resource_group.current.name

  sku {
    tier = "Standard"
    size = "S1"
  }
  
}

resource "azurerm_storage_account" "app_logs" {
  name = "sa${var.environment_name}logsfb01"
  resource_group_name = data.azurerm_resource_group.current.name
  location = data.azurerm_resource_group.current.location
  account_replication_type = "LRS"
  account_tier = "Standard"
}

resource "azurerm_app_service" "current" {
  name                = var.app_service_name
  location            = data.azurerm_resource_group.current.location
  resource_group_name = data.azurerm_resource_group.current.name
  app_service_plan_id = azurerm_app_service_plan.current.id

  site_config {
    dotnet_framework_version = "v6.0"
    scm_type                 = "LocalGit"
  }
  https_only = true
  identity {
    type = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.current.id]
  }
  logs {
    application_logs {
        file_system_level = "Information"
        azure_blob_storage {
          level = "Information"
          retention_in_days = 7
          sas_url = azurerm_storage_account.app_logs.primary_blob_connection_string
        }
    }
    http_logs {
        azure_blob_storage {
          retention_in_days = 7
          sas_url = azurerm_storage_account.app_logs.primary_blob_connection_string
        }
    }
  }
}

output "app_service_id" {
  value = azurerm_app_service.current.id
}

output "logs_storage_account_id" {
  value = azurerm_storage_account.app_logs.id
  
}