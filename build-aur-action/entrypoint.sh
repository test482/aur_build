#!/bin/bash

pkgname=$1

useradd builder -m
echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chmod -R a+rw .

cat << EOM >> /etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
[archlinuxcn]
Server = https://repo.archlinuxcn.org/x86_64
EOM

pacman-key --init
pacman -Sy --noconfirm && pacman -S --noconfirm archlinuxcn-keyring
pacman -Syu --noconfirm --needed base-devel yay
if [ ! -z "$INPUT_PREINSTALLPKGS" ]; then
    yay -Syu --noconfirm "$INPUT_PREINSTALLPKGS"
fi

# fix path
for perl_path_dir in {/usr/bin/site_perl,/usr/bin/vendor_perl,/usr/bin/core_perl}; do
if [[ ! "${PATH}" == *"${perl_path_dir}"* ]]; then
    PATH=$PATH:$perl_path_dir
fi
done

sudo --set-home -u builder yay -S --noconfirm --builddir=./ "$pkgname"
