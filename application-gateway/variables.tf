variable "resource_group_name" {
  description = "Nombre del grupo de recursos de Azure"
  type        = string
  default     = "rg-ejemplo"
}

variable "location" {
  description = "Región de Azure donde desplegar los recursos"
  type        = string
  default     = "westeurope"
}

variable "vnet_name" {
  description = "Nombre de la red virtual"
  type        = string
  default     = "vnet-ejemplo"
}

variable "vnet_address_space" {
  description = "Espacio de direcciones de la red virtual"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
  default     = "subnet-ejemplo"
}

variable "subnet_address_prefix" {
  description = "Prefijo de la subred"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vm_admin_username" {
  description = "Nombre de usuario administrador de la máquina virtual"
  type        = string
  default     = "azureuser"
}

variable "vm_dns_label" {
  description = "Etiqueta DNS para la IP pública de la VM"
  type        = string
  default     = "srv-nddprint-activo"
}

variable "vm_size" {
  description = "Tamaño de la máquina virtual"
  type        = string
  default     = "Standard_B1s"
}

variable "public_key_path" {
  description = "Ruta al archivo de la clave pública SSH"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "appgw_name" {
  description = "Nombre del Application Gateway"
  type        = string
  default     = "appgw-ejemplo"
}

variable "appgw_dns_label" {
  description = "Etiqueta DNS para la IP pública del Application Gateway"
  type        = string
  default     = "appgw-ejemplo"
}

variable "key_vault_name" {
  description = "Nombre del Azure Key Vault"
  type        = string
  default     = "kv-ejemplo"
}
