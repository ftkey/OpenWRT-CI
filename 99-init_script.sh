#!/bin/bash

WRT_IP="192.168.10.1"
WRT_IPPART=$(echo $WRT_IP | cut -d'.' -f1-3)
WRT_Backup_Path="/mnt/mmcblk0p23/"
PRIVATE_WRT_ddns_domain=''
PRIVATE_WRT_ddns_username=''
PRIVATE_WRT_ddns_password=''
PRIVATE_WRT_zerotier_id=''
PRIVATE_WRT_pppoe_username=''
PRIVATE_WRT_pppoe_password=''


if [ -f "/etc/config/dhcp" ]; then
	echo " 
	config host
		option name 'E1630-1'
		option ip '$WRT_IPPART.5'
		list mac '68:77:DA:1D:3F:46'

	config host
		option name 'E1630-2'
		option ip '$WRT_IPPART.6'
		list mac '68:77:DA:07:09:5A'

	config host
		option name 'NAS'
		list mac '00:E2:69:2B:86:A5'
		option ip '$WRT_IPPART.10' 
	" >> /etc/config/dhcp
	echo "dhcp自定义设置完成"
else
	echo "dhcp自定义未初始化"
fi

if [ -f "/etc/config/socat" ]; then
	echo " 
	config config '6bde6d81697f41ac9af31ce9ef8ff429'
		option enable '1'
		option remarks 'NAS'
		option protocol 'port_forwards'
		option family '6'
		option proto 'tcp'
		option listen_port '5001'
		option reuseaddr '1'
		option dest_proto 'tcp4'
		option dest_ip '$WRT_IPPART.10'
		option dest_port '5001'
		option firewall_accept '1'
	" >> /etc/config/socat
	echo "socat自定义设置完成"
else
	echo "socat自定义未初始化"
fi

if [ -f "/etc/config/firewall" ]; then
	echo " 
    config nat
        option name 'openvpn'
        list proto 'all'
        option src '*'
        option src_ip '10.8.0.0/24'
        option target 'MASQUERADE'
        option device 'br-lan'
	" >> /etc/config/firewall
	echo "firewall自定义设置完成"
else
	echo "firewall自定义未初始化"
fi

if [ -f "/etc/config/ddns" ]; then
	echo " 
    config service 'NAS'
        option enabled '0'
        option service_name 'aliyun.com'
        option use_ipv6 '1'
        option lookup_host '$PRIVATE_WRT_ddns_domain'
        option domain '$PRIVATE_WRT_ddns_domain'
        option username '$PRIVATE_WRT_ddns_username'
        option password '$PRIVATE_WRT_ddns_password'
        option use_syslog '2'
        option check_unit 'minutes'
        option force_unit 'minutes'
        option retry_unit 'seconds'
        option ip_source 'interface'
        option ip_interface 'pppoe-wan'
        option interface 'pppoe-wan'
	" >> /etc/config/ddns
	echo "ddns自定义设置完成"
else
	echo "ddns自定义未初始化"
fi
if [ -f "/etc/config/zerotier" ]; then
	echo " 
    config zerotier 'sample_config'
        option enabled '1'
        list join '$PRIVATE_WRT_zerotier_id'
        option nat '1'
 	" > /etc/config/zerotier
	echo "zerotier自定义设置完成"
else
	echo "zerotier自定义未初始化"
fi

if [ -d $WRT_Backup_Path ]; then
	echo "
	backupfilename=$(date +%Y%m%d_%H%M%S)
	tar -czvf $backuppath1/openwrt-backup_$backupfilename-etc.tar.gz /etc 
	opkg list-installed > $backuppath1/openwrt-backup_$backupfilename-soft-list.txt
 	" > $WRT_Backup_Path/auto_backup.sh
	chmod +x $WRT_Backup_Path/auto_backup.sh
	echo "auto_backup自定义设置完成"
	if [ -f "/etc/crontabs/root" ]; then
		echo "
		0 5 * * *  $WRT_Backup_Path/auto_backup.sh
		" >> /etc/crontabs/root
		echo "crontabs自定义设置完成"
	fi
else
	echo "auto_backup自定义未初始化"
fi



