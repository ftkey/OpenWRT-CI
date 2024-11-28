#!/bin/bash

storage_path=$(blkid | grep 'PARTLABEL="storage"' | awk '{print $1}' | sed 's/:$//')
storage_mount_path=$(mount | grep '/dev/mmcblk0p23' | awk '{print $3}')
if [ -d $storage_mount_path ]; then
	echo "
	backupfilename=\$(date +%Y%m%d_%H%M%S)
	tar -czvf $backuppath1/openwrt-backup_$backupfilename-etc.tar.gz /etc 
	opkg list-installed > $backuppath1/openwrt-backup_$backupfilename-soft-list.txt
 	" > $storage_mount_path/auto_backup.sh
	chmod +x $storage_mount_path/auto_backup.sh
	echo "auto_backup自定义设置完成"
	if [ -f "/etc/crontabs/root" ]; then
		echo "0 5 * * *  $storage_mount_path/auto_backup.sh" >> /etc/crontabs/root
		echo "crontabs自定义设置完成"
	fi
else
	echo "auto_backup自定义未初始化"
fi
