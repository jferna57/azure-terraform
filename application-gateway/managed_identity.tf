resource "azurerm_user_assigned_identity" "appgw" {
  name                = "appgw-identity"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}