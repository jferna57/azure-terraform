resource "azurerm_storage_account" "sa" {
  name                     = "ejemploarchivostf1"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Premium"
  account_replication_type = "LRS"
  account_kind             = "FileStorage"
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

resource "azurerm_private_endpoint" "nfs_pe" {
  name                = "nfs-pe"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "nfs-pe-conn"
    private_connection_resource_id  = azurerm_storage_account.sa.id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }
}

resource "azurerm_storage_account_network_rules" "rules" {
  storage_account_id = azurerm_storage_account.sa.id
  default_action     = "Deny"
  virtual_network_subnet_ids = [azurerm_subnet.subnet.id]
}