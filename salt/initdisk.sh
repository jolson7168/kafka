#!/bin/sh
hdd="/dev/xvdb"
for i in $hdd;do
echo "n
p
1


w
"|fdisk $i;mkfs.ext4 $i;done
mkdir /mnt/data
mount /dev/xvdb /mnt/data
export data2="\/mnt\/data"
export data="\/mnt"
sed -i "0,/$data/s//$data2/" /etc/fstab
