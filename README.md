# ER1-WRT-CI
京东云ER1 (设备型号: qualcommax_ipq60xx_DEVICE_jdcloud_re-cs-07)


# 9008 & TTL 下刷UBoot方法

[京东云太乙ER1- 免TTL-9008通刷LiBwrt-lede-QWRT教程.pdf](https://github.com/ftkey/OpenWRT-CI/blob/uboot/UBoot/ER1/%E4%BA%AC%E4%B8%9C%E4%BA%91%E5%A4%AA%E4%B9%99ER1-%20%E5%85%8DTTL-9008%E9%80%9A%E5%88%B7LiBwrt-lede-QWRT%E6%95%99%E7%A8%8B.pdf)


# SSH下刷UBoot方法

千万**不要批量处理**,确保每个命令是否正确执行

    opkg update
    opkg install blkid
    
    wget https://github.com/ftkey/OpenWRT-CI/raw/refs/heads/uboot/UBoot/ER1/R2411-uboot.bin -O /tmp/uboot.bin
    wget https://github.com/ftkey/OpenWRT-CI/raw/refs/heads/uboot/UBoot/ER1/CDT/ER1-2G-CDT-org.bin -O /tmp/ER1-2G-CDT-org.bin
    wget https://github.com/ftkey/OpenWRT-CI/raw/refs/heads/uboot/UBoot/ER1/GPT/DobulePartition/gpt_big.bin -O /tmp/gpt_big.bin

    dd if=/tmp/uboot.bin of=$(blkid -t PARTLABEL=0:APPSBL -o device) conv=fsync && echo "U-Boot第一块分区刷写成功"
    dd if=/tmp/uboot.bin of=$(blkid -t PARTLABEL=0:APPSBL_1 -o device) conv=fsync && echo "U-Boot第二块分区刷写成功"
    dd if=/tmp/ER1-2G-CDT-org.bin of=$(blkid -t PARTLABEL=0:CDT -o device) conv=fsync && echo "CDT第一块分区刷写成功"
    dd if=/tmp/ER1-2G-CDT-org.bin of=$(blkid -t PARTLABEL=0:CDT_1 -o device) conv=fsync && echo "CDT第二块分区刷写成功"
    dd if=/tmp/gpt_big.bin of=/dev/mmcblk0 bs=512 count=34 conv=fsync && echo "GPT刷写成功"
    echo "一次性刷写uboot&CDTGPT完成"

<http://192.168.1.1/uboot.html>

<http://192.168.1.1/gpt.html>

## 12M SSH下刷UBoot方法
千万**不要批量处理**,确保每个命令是否正确执行

    opkg update
    opkg install blkid
    
    wget https://github.com/ftkey/OpenWRT-CI/raw/refs/heads/uboot/UBoot/ER1/u-boot-ER1-HLOS12M-all-in-boom.bin -O /tmp/uboot.bin
    wget https://github.com/ftkey/OpenWRT-CI/raw/refs/heads/uboot/UBoot/ER1/GPT/12M/gpt-JDC_ER1_HLOS12M_rootfs1024M_no-plugin_no-last-partition.bin -O /tmp/gpt_12m.bin
    dd if=/tmp/uboot.bin of=$(blkid -t PARTLABEL=0:APPSBL -o device) conv=fsync && echo "U-Boot第一块分区刷写成功"
    dd if=/tmp/uboot.bin of=$(blkid -t PARTLABEL=0:APPSBL_1 -o device) conv=fsync && echo "U-Boot第二块分区刷写成功"
    dd if=/tmp/gpt_12m.bin of=/dev/mmcblk0 bs=512 count=34 conv=fsync && echo "GPT刷写成功"
    echo "一次性刷写uboot&GPT完成"

<http://192.168.1.1/uboot.html>

<http://192.168.1.1> 6m

<http://192.168.1.1/big.html> 12m

<http://192.168.1.1/img.html>

<http://192.168.1.1/uboot.html>

https://www.right.com.cn/forum/forum.php?mod=viewthread&tid=8402269&highlight=IPQ60xx

**最后拔电|插电|捅菊花!**


## 特别提示
本人不对任何人因使用本固件所遭受的任何理论或实际的损失承担责任！
本固件禁止用于任何商业用途，请务必严格遵守国家互联网使用相关法律规定！

