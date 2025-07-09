resource "azurerm_storage_account" "asr_staging" {
  name                     = "asrstaging${random_integer.unique.result}" # Debe ser único a nivel global
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = {
    environment = "demo"
    purpose     = "asr-staging"
  }
}

resource "random_integer" "unique" {
  min = 10000
  max = 99999
}