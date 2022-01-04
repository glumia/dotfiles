#!/bin/sh
# Check that we are booted in UEFI mode
if [ ! -d /sys/firmware/efi/efivars ]; then
	printf "Error: looks like the system wasn't booted in UEFI mode.\n"
	exit 1
fi

# Check internet connection
if ! ping -c1 www.google.it >/dev/null 2>&1; then
	printf "Error: seems like we are offline, check network config.\n"
	exit 1
fi

# Update system clock
timedatectl set-ntp true
timedatectl status

# Partition disks
printf "Hey it's time to partition disks, better if you do this by hand :)
parted, mkfs.*, cryptsetup, pvcreate, vgcreate, lvcreate are your best
friends for this. Mount the new filesystem on /mnt and the EFI partition
on /mnt/efi. You can switch between the shell and the script with ctrl+z
and the 'fg' command. Come back and press enter as soon as you're done.\n"
read -r _

# Pacstrap
packages=$(cat packages.txt)
lscpu | grep -iE "^Vendor ID:.*Intel" > /dev/null && packages="$packages intel-ucode"
lscpu | grep -iE "^Vendor ID:.*AMD"  > /dev/null && packages="$packages amd-ucode"
lspci -v | grep -e VGA -e 3D | grep AMD > /dev/null \
	&& packages="$packages xf86-video-amdgpu vulkan-radeon"

# Disable warnings about word splitting, it is exactly what we want here.
pacstrap /mnt $packages

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot and continue installation
cp post-chroot.sh /mnt/
arch-chroot /mnt sh post-chroot.sh
rm /mnt/post-chroot.sh

printf "\n\nDone \o/\n\n
Remember to run gnome-conf.sh as soon as you reboot and login (it needs an active
Xsession to work).\n"
