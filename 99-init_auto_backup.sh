#!/bin/bash

storage_dev_path=$(blkid | grep -E '^/dev/mmc' | grep -E 'PARTLABEL="storage"|PARTLABEL="primary"' | awk '{print $1}' | sed 's/:$//')
storage_path=$(mount | grep "$storage_dev_path" | awk '{print $3}')

if [ -d "$storage_path" ]; then
cat << 'EOF' > "$storage_path/auto_backup.sh"
#!/bin/bash
if cmd=$(command -v apk) > /dev/null; then
    flags="list -I"
else
    cmd=$(command -v opkg)
    flags="list-installed"
fi
EOF

cat << EOF >> "$storage_path/auto_backup.sh"
backupdatetime=\$(date +%Y%m%d_%H%M%S)
sysupgrade -b "$storage_path/openwrt-backup_\$backupdatetime.tar.gz"
\$cmd \$flags > "$storage_path/openwrt-backup_\$backupdatetime-soft-list.txt"
######
### 如果存在auto_backup_keep_files.txt，读取精简只保留内容
#etc/hosts
#etc/passwd
#etc/crontabs/
#etc/config/dhcp
######
if [[ -s $storage_path/auto_backup_keep_files.txt ]]; then
	rm -rf $storage_path/backup_extracted $storage_path/backup_keep
	mkdir $storage_path/backup_extracted $storage_path/backup_keep
	
	tar -xzf "$storage_path/openwrt-backup_\${backupdatetime}.tar.gz" -C $storage_path/backup_extracted
	while IFS= read -r file; do
	    # 创建目标目录
	    mkdir -p "$storage_path/backup_keep/\$(dirname "\$file")"
	    # 复制文件或目录
	    cp -r "$storage_path/backup_extracted/\$file" "$storage_path/backup_keep/\$file"
	done < $storage_path/auto_backup_keep_files.txt
	tar -czf $storage_path/openwrt-backup_\${backupdatetime}-lite.tar.gz -C $storage_path/backup_keep etc
	
	rm -rf $storage_path/backup_extracted $storage_path/backup_keep
fi


EOF

    chmod +x "$storage_path/auto_backup.sh"
    if [ -f "/etc/crontabs/root" ]; then
        sed -i '/auto_backup.sh/d' /etc/crontabs/root
        echo "0 5 * * * $storage_path/auto_backup.sh" >> /etc/crontabs/root
        echo "crontabs自定义设置完成"
    fi
else
    echo "无可读写的挂载分区"
fi
