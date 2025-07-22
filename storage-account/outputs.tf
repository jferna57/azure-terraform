output "storage_account_name" {
  description = "Nombre de la cuenta de almacenamiento"
  value       = azurerm_storage_account.sa.name
}

output "storage_account_key" {
  description = "Clave primaria de la cuenta de almacenamiento"
  value       = azurerm_storage_account.sa.primary_access_key
  sensitive   = true
}

output "smb_share_name" {
  description = "Nombre del recurso compartido SMB"
  value       = azurerm_storage_share.smb_share.name
}

output "nfs_share_name" {
  description = "Nombre del recurso compartido NFS"
  value       = azurerm_storage_share.nfs_share.name
}

output "public_ip_vm_0" {
  description = "IP pública de la VM 0"
  value       = azurerm_public_ip.public_ip[0].ip_address
}

output "public_ip_vm_1" {
  description = "IP pública de la VM 1"
  value       = azurerm_public_ip.public_ip[1].ip_address
}

output "smb_mount_command" {
  value = "sudo mount -t cifs //${azurerm_storage_account.sa.name}.file.core.windows.net/${azurerm_storage_share.smb_share.name} /mnt/smbshare -o vers=3.0,username=${azurerm_storage_account.sa.name},password=<storage_key>,dir_mode=0777,file_mode=0777,serverino"
}

output "nfs_mount_command" {
  value = "sudo mount -t nfs -o vers=4,minorversion=1,sec=sys ${azurerm_storage_account.sa.name}.file.core.windows.net:/${azurerm_storage_share.nfs_share.name} /mnt/nfsshare"
}
