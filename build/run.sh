#!/bin/sh

echo "Resetting crashcounter"
fts-set steamlink.crashcounter 0

echo "Mounting stuff"
mount -t proc proc /mnt/disk/proc
mount -o rbind /sys /mnt/disk/sys
mount -o rbind /dev /mnt/disk/dev

#echo "Configuring network"
#ip link set up dev eth0
#ip addr add 10.25.11.10/24 dev eth0
#ip route add default via 10.25.11.1
#sleep 1
#wget -O /mnt/disk/boot/kexec_load.ko http://10.25.11.2:8000/kexec_load.ko
#wget -O /mnt/disk/boot/zImage-mrvl http://10.25.11.2:8000/zImage
#wget -O /mnt/disk/boot/dtbs/steamlink.dtb http://10.25.11.2:8000/steamlink.dtb
#sync

echo "Executing stuff"
insmod /mnt/disk/boot/kexec_load.ko
chroot /mnt/disk/ /usr/bin/kexec -l /boot/zImage-mrvl --initrd /boot/initramfs-linux.img --dtb /boot/dtbs/steamlink.dtb
chroot /mnt/disk/ /usr/bin/kexec -e
