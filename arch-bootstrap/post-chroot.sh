#!/bin/sh

# Set time zone
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc

# Localization
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
printf "LANG=en_US.UTF-8\n" > /etc/locale.conf
printf "KEYMAP=us" > /etc/vconsole.conf

# Set hostname
printf "Please insert the desired hostname and press enter: "
read -r hname
printf '%s' "$hname" > /etc/hostname
printf "%s\n" \
	"127.0.0.1	localhost" \
	"::1		localhost" \
	"127.0.1.1	$hname" >> /etc/hosts

# Configure initramfs
printf "Did you partition disks with LVM and/or full-disk encryption?
Check hooks in your /etc/mkinitcpio.conf and press enter as soon as you're done.\n"
read -r _
mkinitcpio -P

# Change root passwd
printf "Please insert the desired password for root.\n"
passwd

# Install boot loader
efi_path=$(mount | grep 'efi.*vfat' | cut -d' ' -f3)
if [ -z "$efi_path" ]; then
	printf "Error: can't find EFI partition mount point.\n"
	exit 1
fi
grub-install --target=x86_64-efi --efi-directory="$efi_path" --bootloader-id=grub

printf "\n# Enable search for other oses with os-probe
GRUB_DISABLE_OS_PROBER=false\n" >> /etc/default/grub

printf "Did you setup LVM partitions and/or full-disk encryption?
If yes, edit /etc/default/grub to append 'lvm' to GRUB_PRELOAD_MODULES and check
GRUB_CMDLINE_LINUX_DEFAULT for crypto configs, then press enter to continue."
read -r _
grub-mkconfig -o /boot/grub/grub.cfg

# Configure user
printf "Please insert the desired username: "
read -r uname
useradd -m -G adm,ftp,games,http,log,rfkill,sys,systemd-journal,uucp,wheel "$uname"
passwd "$uname"

# Add user to sudoers
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

# Enable systemd services
systemctl enable gdm.service
systemctl enable systemd-timesyncd.service
systemctl enable systemd-resolved.service
systemctl enable bluetooth.service
systemctl enable NetworkManager.service
systemctl enable NetworkManager-dispatcher.service
systemctl enable cups.service
systemctl enable fstrim.timer
systemctl enable reflector.timer

printf "\n\n"

# Configure userspace
# shellcheck disable=SC2016,SC1004
sudo -Hu "$uname" su -c 'git clone https://github.com/glumia/dotfiles.git \
	$HOME/dotfiles \
	&& cd $HOME/dotfiles  \
	&& sh install.sh'
