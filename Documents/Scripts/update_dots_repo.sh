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


#cd into the dotfiles directory so the git status --porcelain doesnt return nothing
cd ~/Documents/dotfiles/ || exit


#Document Folders Copy
include=(--include 'Hyprlock Assets/' --include 'Scripts/' --include 'Wallpapers/' --exclude '*/')

echo "Copying document folders..."

rsync -av --checksum --mkpath "${include[@]}" ~/Documents/ ~/Documents/dotfiles/Documents/

#.config Folders Copy

echo "Copying .config folders..."

include=(--include 'hypr/' --include 'waybar/' --include 'foot/' --include 'macchina/' --include 'macchina/themes/' --exclude '*/')

rsync -av --checksum --mkpath "${include[@]}" ~/.config/ ~/Documents/dotfiles/.config

rm -f ~/Documents/dotfiles/.config/*
rm -f ~/Documents/dotfiles/.config/.*

echo "Copying config from flatpaks..."

rsync -av --checksum --mkpath ~/.var/app/io.github.hrkfdn.ncspot/config/ncspot/ ~/Documents/dotfiles/.var/app/io.github.hrkfdn.ncspot/config/ncspot/

rm -f ~/Documents/dotfiles/.var/app/io.github.hrkfdn.ncspot/config/ncspot/userstate.cbor

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

#/home/astro/.var/app/io.github.hrkfdn.ncspot/config/ncspot/
