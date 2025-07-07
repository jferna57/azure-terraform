# Key Vault
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                        = "kv-ejemplo"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set"
    ]
    key_permissions = [
      "Get",
      "List",
      "Create"
    ]
    certificate_permissions = [
      "Get",
      "List",
      "Create"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.appgw.principal_id # o la principal_id de la identidad SystemAssigned

    secret_permissions = [
      "Get",
      "List"
    ]
  }
}