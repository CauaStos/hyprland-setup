#!/bin/bash

# AUR Helper and Packages installation.

## Paru
echo "Installing AUR Helper (Paru)"

sudo pacman -S --needed --noconfirm base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd .. #we 'cd ..' since we are inside of paru/


## Packages installation
echo "Installing necessary packages"

### Std
sudo pacman -S --noconfirm hyprland unzip unrar sddm polkit-gnome swww hypridle nwg-look hyprlock zed thunar hyprpicker macchina zoxide starship mission-center pipewire pipewire-pulse pipewire-audio pipewire-alsa fish rsync file-roller qt5ct qt6ct gnome-keyring wtype wget fastfetch vlc ripgrep python-watchdog python-colorthief python-setuptools

### AUR
paru -S --noconfirm spicetify-cli zen-browser-bin spotify vesktop hyprshot appimagelauncher matugen-bin wezterm-git apple-fonts python-colormath papirus-folders python-pywalfox


## Changing default shell
echo "Changing the default shell to Fish."

chsh -s /usr/bin/fish


## Enabling spicetify (TODO)



# Moving files to home
echo "Moving files to home. '~/'"

rsync -av --checksum --mkpath ./.config ./home/ ~/



# Enabling services
echo "Enabling necessary services."

systemctl enable sddm --now



# End

echo "Done!"
exit 0
