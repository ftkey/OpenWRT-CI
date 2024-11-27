# ER1-WRT-CI
京东云ER1 (设备型号: qualcommax_ipq60xx_DEVICE_jdcloud_re-cs-07)

## 云编译OpenWRT固件
[![QCA-ALL](https://github.com/ftkey/OpenWRT-CI/actions/workflows/QCA-ALL.yml/badge.svg)](https://github.com/ftkey/OpenWRT-CI/actions/workflows/QCA-ALL.yml)

### 高通版(NSS) 
    OWRT: https://github.com/VIKINGYFY/immortalwrt.git 
    LibWRT: https://github.com/LiBwrt-op/openwrt-6.x.git 
    LEDE: https://github.com/coolsnowwolf/lede.git 

## 编译时间
固件自动每天早上4点自动编译

## 固件信息
### OWRT & LibWRT: 
    带NSS的6.6内核固件，默认主题为Argon；默认使用nftables防火墙（fw4）。
    默认管理地址：192.168.1.1 默认用户：root 默认密码：无
### LEDE: 
    带NSS的6.1内核固件，默认主题为Argon；默认使用iptable防火墙（fw3）。
    默认管理地址：192.168.1.1 默认用户：root 默认密码：password
### LEDE-FW4:    
    带NSS的6.1内核固件，默认主题为Argon；默认使用nftables防火墙（fw4）。
    默认管理地址：192.168.1.1 默认用户：root 默认密码：password

## 刷机方法:
### LEDE:
    Hugo Uboot + 原厂CDT + 双分区GPT
    Uboot 刷入squashfs-recovery.bin #第一次刷完5分钟,之后重启15秒开机。
    Luci 刷入squashfs-sysupgrade.bin #不保留配置开机1分钟开机。

### LibWRT & OWRT:
    Hugo Uboot + 原厂CDT + 单/双分区GPT
    Uboot 刷入squashfs-factory.bin #第一次刷完5分钟,之后重启15秒开机。
    Luci 刷入squashfs-sysupgrade.bin #不保留配置开机1分钟开机。

## 软件包
<details><summary>CONFIG_PACKAGE_luci-app-xxx=y</summary>
    
    ```
    CONFIG_PACKAGE_luci-app-ssr-plus=y // LEDE
    CONFIG_PACKAGE_luci-app-homeproxy=y // OWRT|LIBWRT|LEDE-FW4
    CONFIG_PACKAGE_luci-app-advancedplus=y
    CONFIG_PACKAGE_luci-app-alist=y
    CONFIG_PACKAGE_luci-app-cpufreq=y
    CONFIG_PACKAGE_luci-app-ddns=y
    CONFIG_PACKAGE_luci-app-diskman=y
    CONFIG_PACKAGE_luci-app-diskman_INCLUDE_btrfs_progs=y
    CONFIG_PACKAGE_luci-app-diskman_INCLUDE_lsblk=y
    CONFIG_PACKAGE_luci-app-msd_lite=y
    CONFIG_PACKAGE_luci-app-openvpn-server=y
    CONFIG_PACKAGE_luci-app-samba4=y
    CONFIG_PACKAGE_luci-app-socat=y
    CONFIG_PACKAGE_luci-app-ttyd=y
    CONFIG_PACKAGE_luci-app-turboacc=y
    CONFIG_PACKAGE_luci-app-wolplus=y
    CONFIG_PACKAGE_luci-app-zerotier=y
    CONFIG_PACKAGE_luci-theme-argon=y
    ```

</details>
<details><summary>CONFIG_PACKAGE_luci-app-xxx=n</summary>
    
    ```
    
    ```

</details>


## THKS
VIKINGYFY | LiBwrt-op | laipeng668 | ImmortalWRT | LEDE

## 特别提示
本人不对任何人因使用本固件所遭受的任何理论或实际的损失承担责任！
本固件禁止用于任何商业用途，请务必严格遵守国家互联网使用相关法律规定！

