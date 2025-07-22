#!/bin/bash
apt-get update
apt-get install -y cifs-utils nfs-common

# Montar el recurso SMB
mkdir -p /mnt/smbshare
echo "//${storage_account_name}.file.core.windows.net/${smb_share_name} /mnt/smbshare cifs vers=3.0,username=${storage_account_name},password=${storage_account_key},dir_mode=0777,file_mode=0777,serverino 0 0" >> /etc/fstab

# Montar el recurso NFS
mkdir -p /mnt/nfsshare
echo "${storage_account_name}.file.core.windows.net:/${nfs_share_name} /mnt/nfsshare nfs vers=4,minorversion=1,sec=sys,_netdev,nofail 0 0" >> /etc/fstab

mount -a
