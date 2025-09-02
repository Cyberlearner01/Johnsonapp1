resource "azurerm_resource_group" "rg" {
  name     = "JohnsonApp-RG"
  location = "Canada Central"
}
resource "azurerm_app_service_plan" "asp" {
  name                     = "JohnsonApp-Plan"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku {
    tier = "PremiumV3"
    size = "P1V3"
  }
  kind = "Linux"
  reserved = true
}

resource "azurerm_app_service" "app" {
  name                = "JohnsonApp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "DOTNETCORE|8.0"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
resource "azurerm_app_service_slot" "staging" {
  name                 = "staging"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  app_service_name     = azurerm_app_service.app.name
  app_service_plan_id  = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "DOTNETCORE|8.0"
  }
}
resource "azurerm_monitor_autoscale_setting" "autoscale" {
  name                = "JohnsonApp-Autoscale"
  resource_group_name = azurerm_resource_group.rg.name
  target_resource_id  = azurerm_app_service_plan.asp.id
  location            = azurerm_resource_group.rg.location

  profile {
    name = "AutoScaleCPU"
    capacity {
      minimum = "1"
      maximum = "3"
      default = "1"
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.asp.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.asp.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "JohnsonApp-LogAnalytics"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
resource "azurerm_application_insights" "app_insights" {
  name                = "JohnsonApp-AI"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.log_analytics.id
}
resource "azurerm_monitor_diagnostic_setting" "app_service_diag" {
  name                       = "appservice-diag"
  target_resource_id          = azurerm_app_service.app.id
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.log_analytics.id

  log {
    category = "AppServiceConsoleLogs"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "AppServiceHTTPLogs"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}

# Front Door (Standard) placeholder — comment out until imported
# resource "azurerm_frontdoor_standard" "fd" {
#   name                = "Johnnyapp-fd"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
# }