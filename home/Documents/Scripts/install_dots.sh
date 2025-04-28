#!/bin/bash

#installing packages that are used by config (and AUR helper).

#paru install

echo "Installing AUR Helper (Paru)"

sudo pacman -S --needed --noconfirm base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si && cd .. #we 'cd ..' since we are inside of paru


#arch packages installation

echo "Installing necessary packages (pacman)"

sudo pacman -S --noconfirm hyprland unzip unrar sddm polkit-gnome swww hypridle nwg-look hyprlock zed thunar hyprpicker macchina zoxide starship mission-center pipewire pipewire-pulse pipewire-audio pipewire-alsa fish rsync file-roller qt5ct qt6ct gnome-keyring wtype wget fastfetch vlc

#AUR packages installation

echo "Installing necessary packages (AUR)"

paru -S --noconfirm spicetify-cli zen-browser-bin spotify vesktop opentabletdriver hyprshot appimagelauncher matugen-bin wezterm-git

#Installing fish

echo "making fish the default shell."

chsh -s /usr/bin/fish

#Installing spicetify

#spicetify


#Copying folders to home

echo "Moving files to home. '~/'"
rsync -av --checksum --mkpath ./Documents ./.config ./home/ ~/

#Enabling Services

echo "Enabling necessary services. (Just a precaution)"

systemctl enable sddm
systemctl enable NetworkManager

echo "Done!"
exit 0
