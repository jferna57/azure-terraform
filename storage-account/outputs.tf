output "storage_account_key" {
  value     = azurerm_storage_account.sa.primary_access_key
  sensitive = true
}
output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}
output "fileshare_name" {
  value = azurerm_storage_share.fileshare.name
}

output "public_ip_vm_0" {
  value = azurerm_public_ip.public_ip[0].ip_address
}

output "public_ip_vm_1" {
  value = azurerm_public_ip.public_ip[1].ip_address
}