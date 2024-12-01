#!/bin/bash

storage_dev_path=$(blkid | grep -E 'PARTLABEL="storage"|PARTLABEL="primary"' | awk '{print $1}' | sed 's/:$//')
storage_path=$(mount | grep "$storage_dev_path" | awk '{print $3}')

if cmd=$(command -v apk) > /dev/null; then
    flags="list -I"
else
    cmd=$(command -v opkg)
    flags="list-installed"
fi

if [ -d "$storage_path" ]; then
    cat << EOF > "$storage_path/auto_backup.sh"
    #!/bin/bash
    backupdatetime=\$(date +%Y%m%d_%H%M%S)
    tar -czvf "$storage_path/openwrt-backup_\$backupdatetime-etc.tar.gz" /etc
    $cmd $flags > "$storage_path/openwrt-backup_\$backupdatetime-soft-list.txt"
EOF

    chmod +x "$storage_path/auto_backup.sh"
    if [ -f "/etc/crontabs/root" ]; then
        echo "0 5 * * * $storage_path/auto_backup.sh" >> /etc/crontabs/root
        echo "crontabs自定义设置完成"
    fi
else
    echo "无可读写的挂载分区"
fi