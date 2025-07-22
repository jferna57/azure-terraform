# Proyecto Terraform - Azure Linux VMs con Azure Files (SMB + NFS)

Este proyecto despliega una pequeña infraestructura en Azure usando Terraform, diseñada para ambientes de prueba o desarrollo. Crea dos máquinas virtuales Linux y monta dos Azure File Shares (uno por SMB y otro por NFS) en ambas VMs.

## 🚀 ¿Qué hace?

- Crea un grupo de recursos en Azure
- Provisiona dos máquinas virtuales Linux (Ubuntu)
- Configura una red virtual y subred privada
- Crea una cuenta de almacenamiento tipo Premium
- Crea dos Azure Files:
  - Un recurso compartido SMB
  - Un recurso compartido NFS
- Monta automáticamente los recursos compartidos en las VMs usando cloud-init

## 📂 Estructura del proyecto

├── main.tf # Recursos principales (GR, red, VMs)
├── storage.tf # Azure Files (SMB y NFS)
├── variables.tf # Variables necesarias
├── outputs.tf # Datos de salida útiles (IPs, rutas)
├── scripts/
│ └── mount_azure_files.sh.tpl # Script que se ejecuta al arrancar (cloud-init)
├── terraform.tfvars # Archivo con tus valores personales (opcional)
├── README.md # Este archivo

## ✅ Requisitos

- Azure CLI (`az`) autenticado (`az login`)
- Terraform v1.5 o superior
- Clave pública SSH generada (`~/.ssh/id_rsa.pub`)

## ⚙️ Despliegue

1. Inicializa el proyecto

```bash
terraform init
```

2. Aplica el despliegue

```bash
terraform apply
```

3. Espera y toma nota de las IPs públicas y recursos salientes mostrados al final.

## 🧹 Limpieza

Cuando termines, puedes destruir toda la infraestructura:

```bash
terraform destroy
```

## 📝 Notas

- La carpeta `/mnt/smbshare` montará el recurso compartido SMB.
- La carpeta `/mnt/nfsshare` montará el recurso NFS.
- El script de montaje se ejecuta automáticamente al crear cada VM.

---
