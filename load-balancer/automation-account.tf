resource "azurerm_automation_account" "asr_automation" {
  name                = "asr-autoacct-demo"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = "Basic"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "asr"
    purpose     = "automation-account-for-site-recovery"
  }
}