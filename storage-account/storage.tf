resource "azurerm_storage_account" "sa" {
  name                     = "azurefilesejemplo0"  # debe ser único
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "smb_share" {
  name                 = "smb-share"
  storage_account_id   = azurerm_storage_account.sa.id
  quota                = 100
  enabled_protocol     = "SMB"
}

resource "azurerm_storage_share" "nfs_share" {
  name                  = "nfs-share"
  storage_account_id    = azurerm_storage_account.sa.id
  quota                 = 100
  enabled_protocol      = "NFS"
}