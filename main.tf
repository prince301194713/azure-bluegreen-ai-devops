provider "azurerm" {
  features {}
  subscription_id = "766e8ce8-22bd-4201-814d-c8a4caa40201"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-bluegreen-demo"
  location = "Central India"
}

resource "azurerm_service_plan" "asp" {
  name                = "asp-bluegreen"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "bluegreen-demo-app-301194"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }
}

resource "azurerm_linux_web_app_slot" "green" {
  name           = "green"
  app_service_id = azurerm_linux_web_app.app.id

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }
}
