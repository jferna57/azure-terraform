#!/bin/bash
set -e

# Importa clave del repositorio Microsoft
curl -sSL https://packages.microsoft.com/keys/microsoft.asc > /etc/apt/trusted.gpg.d/microsoft.asc

# Añade repo de paquetes Microsoft según versión de Ubuntu
ver=20.04 # o 22.04 según corresponda
apt-add-repository "https://packages.microsoft.com/ubuntu/$ver/prod"
apt-get update

# Instala aznfs helper (puedes instalar aztfexport si lo requieres)
DEBIAN_FRONTEND=noninteractive apt-get install -y aznfs

# Crea punto de montaje si no existe
mkdir -p /mnt/nfsshare

# Monta NFS si no está montado
if ! mountpoint -q /mnt/nfsshare; then
  mount -t aznfs \
    "${storage_account_name}.file.core.windows.net:/${storage_account_name}/${nfs_share_name}" /mnt/nfsshare \
    -o vers=4,minorversion=1,sec=sys,nconnect=4
fi

# Añade entrada a /etc/fstab si no existe
FSTAB_ENTRY="${storage_account_name}.file.core.windows.net:/${storage_account_name}/${nfs_share_name} /mnt/nfsshare aznfs defaults,sec=sys,vers=4.1,nolock,proto=tcp,nofail,_netdev 0 2"
grep -qF "$FSTAB_ENTRY" /etc/fstab || echo "$FSTAB_ENTRY" >> /etc/fstab

# Monta recurso SMB, si es necesario
mkdir -p /mnt/smbshare
SMB_FSTAB="//${storage_account_name}.file.core.windows.net/${smb_share_name} /mnt/smbshare cifs vers=3.0,username=${storage_account_name},password=${storage_account_key},dir_mode=0777,file_mode=0777,serverino 0 0"
grep -qF "$SMB_FSTAB" /etc/fstab || echo "$SMB_FSTAB" >> /etc/fstab

# Monta todas las entradas pendientes
mount -a
