#!/bin/bash

#installing packages that are used by config. (Also installing AUR Helper of my preference, YAY)

#yay install

echo "Installing AUR Helper (YAY)"

sudo pacman -S --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si && cd .. #we 'cd ..' since we are inside of yay-bin

#arch packages installation

echo "Installing necessary packages (pacman)"

sudo pacman -S --noconfirm hyprland sddm polkit-gnome swww hypridle nwg-look hyprlock zed thunar hyprpicker macchina zoxide starship mission-center pipewire pipewire-pulse pipewire-audio pipewire-alsa zsh rsync fuzzel qt5ct qt6ct gnome-keyring wtype wget

#AUR packages installation

echo "Installing necessary packages (AUR)"

yay -S --noconfirm hyprsunset zen-browser-bin spotify vesktop opentabletdriver hyprshot quicksand-font appimagelauncher matugen-bin aylurs-gtk-shell-git wezterm-git

#Installing Papirus Icons
echo "Installing Papirus icons (Local, not Global)"

wget -qO- https://git.io/papirus-folders-install | env PREFIX=$HOME/.local sh
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh

#Installing Oh-My-Zsh

echo "Installing Oh-My-Zsh and making Zsh the default shell."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

chsh -s /usr/bin/zsh

#Installing ZSH Extensions

echo "Installing Zsh extensions (zsh-autosuggestions, zsh-syntax-highlighting)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


#Copying folders to home

echo "Moving files to home. '~/'"
rsync -av --checksum --mkpath ./Documents ./.config ./home/ ~/

#Enabling Services

echo "Enabling necessary services. (Just a precaution)"

systemctl enable sddm
systemctl enable NetworkManager

echo "Done!"
exit 0
