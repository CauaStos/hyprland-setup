#!/bin/bash
#Tutorial INSANO pro rsync aqui tá
#
#
#-a: Archive mode, which preserves permissions, timestamps, and recursively copies directories.
#-v: Verbose, shows progress.
#--exclude: Specifies each folder or file to exclude from the copy.
#--include: Specifies each folder or file to include from the specified path.
#--checksum: Checks for minor changes in files instead of timestamps. (Specifically, checks for file size instead of timestamps)
#--mkpath: Creates folders if there are none
#--delete: Will delete files in the directory if they are not in the source. (e.g: if a wallpaper is deleted on ./Documents/Wallpapers and rsync with --delete, it will also remove the wallpaper on ./dotfiles/Documents/Wallpapers)

RSYNC_OPTS="-av --checksum --mkpath"


#cd into the dotfiles directory so git status --porcelain doesnt return nothing
cd ~/Documents/dotfiles/ || exit
rm -rf ./.config ./home ./Documents


#Document Folders Copy
include=(--include 'Hyprlock Assets/' --include 'Scripts/' --include 'Scripts/colors/' --include 'Wallpapers/' --exclude '*/')

echo "Copying 'Documents' folders..."

rsync -av --checksum --mkpath "${include[@]}" ~/Documents/ ~/Documents/dotfiles/Documents/


#Specific folders and files copy
echo "Copying specific folders and files..."

rsync $RSYNC_OPTS ~/.zshrc ~/Documents/dotfiles/home/

rsync $RSYNC_OPTS ~/.local/share/zed/extensions/ ~/Documents/dotfiles/home/.local/share/zed/extensions/

rsync $RSYNC_OPTS ~/.local/share/themes/Material ~/Documents/dotfiles/home/.local/share/themes/

rsync $RSYNC_OPTS ~/.config/ags ~/Documents/dotfiles/.config


#.config Folders Copy

echo "Copying '.config' folders..."

include=(--include 'hypr/' --include 'macchina/' --include 'macchina/themes/' --include 'qt5ct/' --include 'qt5ct/colors/' --include 'qt6ct/' --include 'qt6ct/colors/' --include 'zed/' --include 'matugen/' --include 'matugen/templates/' --exclude '*/')

rsync $RSYNC_OPTS "${include[@]}" ~/.config/ ~/Documents/dotfiles/.config

rm -f ~/Documents/dotfiles/.config/*
rm -f ~/Documents/dotfiles/.config/.*

echo "Copying '.config' files"

cp ~/.config/electron-flags.conf  ~/Documents/dotfiles/.config/

#echo "Copying SDDM theme..."

#rsync -av --checksum --mkpath /usr/share/sddm/themes/where_is_my_sddm_theme/ ~/Documents/dotfiles/sddm/themes/where_is_my_sddm_theme/

#Moving install_dots.sh to project's root.
echo "Moving install script to project's root"

cp ./Documents/Scripts/install_dots.sh ./


if [[ $(git status --porcelain) ]]; then
    echo "pushing changes"

    git add .
    git commit -m "Updating dotfiles"
    git push origin main
else
    echo "no changes to commit"
fi

echo "Done!"
exit 0
