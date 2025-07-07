output "resource_group_name" {
  description = "Nombre del grupo de recursos creado"
  value       = azurerm_resource_group.main.name
}

output "virtual_network_name" {
  description = "Nombre de la red virtual"
  value       = azurerm_virtual_network.main.name
}

output "subnet_id" {
  description = "ID de la subred"
  value       = azurerm_subnet.main.id
}

output "vm_public_ip" {
  description = "IP pública de la máquina virtual"
  value       = azurerm_public_ip.vm.ip_address
}

output "vm_dns" {
  description = "Nombre DNS público de la máquina virtual"
  value       = azurerm_public_ip.vm.fqdn
}

output "appgw_public_ip" {
  description = "IP pública del Application Gateway"
  value       = azurerm_public_ip.appgw.ip_address
}

output "appgw_dns" {
  description = "Nombre DNS público del Application Gateway"
  value       = azurerm_public_ip.appgw.fqdn
}

output "key_vault_uri" {
  description = "URI del Azure Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}
