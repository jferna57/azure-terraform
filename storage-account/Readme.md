# Proyecto Terraform: Infraestructura Básica en Azure con Azure Files por SMB

Este proyecto provisiona una infraestructura básica en Microsoft Azure usando Terraform. Implementa los siguientes recursos:

- 2 máquinas virtuales Linux (Ubuntu) de tamaño básico (Standard_B1s)
- Red virtual con subred privada
- Cuenta de almacenamiento con Azure Files habilitado y exportado por SMB
- Montaje automático del recurso Azure File Share en ambas VMs Linux mediante `cloud-init`

## ⚙️ Requisitos

- Terraform ≥ 1.5
- Cuenta de Azure con permisos para crear recursos
- Clave pública SSH generada previamente
- `az` CLI para obtener credenciales de `az login`
