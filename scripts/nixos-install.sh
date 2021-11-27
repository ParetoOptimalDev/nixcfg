#!/usr/bin/env bash

# Source: https://qfpl.io/posts/installing-nixos/

set -x

$HOSTNAME="altair"
$DISK="/dev/nvme0n1"
$BOOT_PARTITION="/dev/nvme0n1p1"
$LVM_PARTITION="/dev/nvme0n1p2"
$RAM_GB="16"

partition() {
    echo "Partition as described in https://qfpl.io/posts/installing-nixos/#partitioning"
    exit 1
}

create_volumes() {
    cryptsetup luksFormat $LVM_PARTITION
    cryptsetup luksOpen $LVM_PARTITION nixos-enc
    pvcreate /dev/mapper/nixos-enc
    vgcreate nixos-vg /dev/mapper/nixos-enc
    lvcreate -L "${RAM_GB}G" -n swap nixos-vg
    lvcreate -l 100%FREE -n root nixos-vg
}

create_filesystems() {
    mkfs.vfat -n boot $BOOT_PARTITION
    mkfs.ext4 -L nixos /dev/nixos-vg/root
    mkswap -L swap /dev/nixos-vg/swap
    swapon /dev/nixos-vg/swap
}

mount_volumes() {
    cryptsetup luksOpen $LVM_PARTITION nixos-enc
    lvscan
    vgchange -ay
}

install() {
    mount /dev/nixos-vg/root /mnt
    mkdir /mnt/boot
    mount $BOOT_PARTITION /mnt/boot
    nixos-generate-config --root /mnt
    mkdir -p /mnt/home/christian
    git clone https://github.com/christianharke/nixos-config.git /mnt/home/christian/nixos-config
    /mnt/home/christian/nixos-config/scripts/nixos-setup.sh
    hostname $HOSTNAME
    nixos-install
    reboot
}

read -p "Do you want to DELETE ALL PARTITIONS?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    partition()
    create_volumes()
    create_filesystems()
else
    mount_volumes()
fi

read -p "Do you want to INSTALL NixOS now? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    install()
fi

