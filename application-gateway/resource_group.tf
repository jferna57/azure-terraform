# Grupo de recursos
resource "azurerm_resource_group" "main" {
  name     = "poc-iam-terraform"
  location = "westeurope"
}