#!/usr/bin/env bash

# Source: https://qfpl.io/posts/installing-nixos/

set -e
set -x


### Gather system info

readonly HOSTNAME="${1}"
readonly DISK="${2}"

test "${HOSTNAME}" || { echo '$HOSTNAME is not given!'; exit 1; }
[[ $(echo "${DISK}" | grep -P "^/dev/(sd[a-z]|nvme[0-9]n[1-9])$" -c) -gt 0 ]] || { echo '$DISK is not of format "/dev/sda" or "/dev/nvme0n1"!'; exit 1; }

is_nvme_disk() {
    [[ $(echo "${DISK}" | grep "^/dev/nvme" -c) -gt 0 ]]
}

get_partition() {
    if is_nvme_disk; then
        echo "${DISK}p${1}"
    else
        echo "${DISK}${1}"
    fi
}

BOOT_PARTITION="$(get_partition 1)"
readonly BOOT_PARTITION
LVM_PARTITION="$(get_partition 2)"
readonly LVM_PARTITION

get_ram_size() {
    lsmem --summary=only | grep "Total online memory:" | grep -Po "[0-9]+[kKmMgGtTpPeE]"
}

RAM_SIZE="$(get_ram_size)"
readonly RAM_SIZE


### Declare functions

readonly LVM_PV="nixos-enc"
readonly LVM_VG="nixos-vg"
readonly LVM_LV_ROOT="/dev/${LVM_VG}/root"
readonly LVM_LV_SWAP="/dev/${LVM_VG}/swap"

partition() {
    echo "[partition] Deleting partitions..."
    dd if=/dev/zero of="${DISK}" bs=512 count=1 conv=notrunc status=progress

    echo "[partition] Creating partition table..."
    parted "${DISK}" mklabel gpt
    parted "${DISK}" mkpart "boot" fat32 0% 1GiB
    parted "${DISK}" set 1 esp on
    parted "${DISK}" mkpart "root" ext4 1GiB 100%

    echo "[partition] Result of partitioning:"
    fdisk "${DISK}" -l
}

create_volumes() {
    echo "[create_volumes] Encrypting LVM partition..."
    cryptsetup luksFormat "${LVM_PARTITION}"
    cryptsetup luksOpen "${LVM_PARTITION}" "${LVM_PV}"

    echo "[create_volumes] Creating LVM volumes..."
    pvcreate /dev/mapper/${LVM_PV}
    vgcreate "${LVM_VG}" /dev/mapper/${LVM_PV}
    lvcreate -L "${RAM_SIZE}" -n swap "${LVM_VG}"
    lvcreate -l 100%FREE -n root "${LVM_VG}"
}

create_filesystems() {
    # TODO: Switch to btrfs (https://github.com/wiltaylor/dotfiles/blob/master/tools/makefs-nixos)
    echo "[create_filesystems] Creating filesystems..."
    mkfs.vfat -n boot "${BOOT_PARTITION}"
    mkfs.ext4 -L nixos "${LVM_LV_ROOT}"
    mkswap -L swap "${LVM_LV_SWAP}"

    echo "[create_filesystems] Result of filesystems creation:"
    lsblk -f "${DISK}"
}

decrypt_lvm() {
    echo "[decrypt_lvm] Decrypting volumes..."
    cryptsetup luksOpen "${LVM_PARTITION}" "${LVM_PV}"
    lvscan
    vgchange -ay

    echo "[decrypt_lvm] Volumes decrypted:"
    lsblk -f "${DISK}"
}

install() {
    local mount_root="/mnt"
    local mount_boot="${mount_root}/boot"

    echo "[install] Enabling swap..."
    if [[ $(swapon --noheadings | wc -l) -lt 1 ]]; then
        swapon -v "${LVM_LV_SWAP}"
    fi

    echo "[install] Mounting volumes..."
    mount "${LVM_LV_ROOT}" "${mount_root}"
    mkdir -p "${mount_boot}"
    mount "${BOOT_PARTITION}" "${mount_boot}"

    echo "[install] Installing NixOS..."
    nixos-install --root "${mount_root}" --flake "github:christianharke/nixos-config/master#${HOSTNAME}" --impure
    echo "[install] Installing NixOS... finished!"

    echo "[install] Installation finished, please reboot and remove installation media..."
}


### Pull the trigger

read -p "Do you want to DELETE ALL PARTITIONS? " -n 1 -r REPLY_PARTITION
echo # move to a new line
if [[ "${REPLY_PARTITION}" =~ ^[Yy]$ ]]; then
    partition
    create_volumes
    create_filesystems
fi

if [[ $(cryptsetup -q status "${LVM_PV}" | grep "^/dev/mapper/${LVM_PV} is active and is in use.$" -c) -lt 1 ]]; then
    decrypt_lvm
fi

read -p "Do you want to INSTALL NixOS now? " -n 1 -r REPLY_INSTALL
echo # move to a new line
if [[ "${REPLY_INSTALL}" =~ ^[Yy]$ ]]; then
    install
fi

