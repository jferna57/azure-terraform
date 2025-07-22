#!/bin/bash
apt-get update
apt-get install -y cifs-utils
MOUNT_POINT="/mnt/azurefileshare"
mkdir -p $MOUNT_POINT
echo "//${storage_account_name}.file.core.windows.net/${fileshare_name} $MOUNT_POINT cifs vers=3.0,username=${storage_account_name},password=${storage_account_key},dir_mode=0777,file_mode=0777,serverino 0 0" >> /etc/fstab
mount -a
