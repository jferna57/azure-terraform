output "resource_group_name" {
  description = "Nombre del grupo de recursos creado"
  value       = azurerm_resource_group.main.name
}

output "public_ip" {
  description = "Dirección IP pública del Load Balancer"
  value       = azurerm_public_ip.main.ip_address
}