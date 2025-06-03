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
#--filter: Filters files, preferred over --include and --exclude.


RSYNC_OPTS="-a --checksum --mkpath"
DOTFILES_PATH=~/Documents/dotfiles

#cd into the dotfiles directory so git status --porcelain doesnt return nothing
cd $DOTFILES_PATH || exit
rm -rf ./.config ./home

echo "# Copying home files and folders..."

filter=(--filter '+ .local/' --filter '+ .local/share/' --filter '+ .local/share/themes/***' --filter '- *')
rsync $RSYNC_OPTS "${filter[@]}" ~/ $DOTFILES_PATH/home/

#Zen Chrome and profile setup
filter=(--filter '+ Zen/***' --filter '+ storage/' --filter '- *')
rsync $RSYNC_OPTS "${filter[@]}" ~/Documents/ZenConfig/ $DOTFILES_PATH/home/.zen/

#Document Folders Copy
echo "## Copying 'Documents' folders..."

filter=(--filter '+ Scripts/***' --filter '+ Scripts/colors/***' --filter '+ Wallpapers/***' --filter '+ ZenConfig/***' --filter '- *')

rsync $RSYNC_OPTS "${filter[@]}" ~/Documents/ $DOTFILES_PATH/home/Documents/

#.config Folders Copy

echo "## Copying '.config' files and folders..."

filter=(--filter '+ AShell/***' --filter '+ hypr/***' --filter '+ fish/***' --filter '+ fastfetch/***' --filter '+ qt5ct/***' --filter '+ qt6ct/***' --filter '+ nvim/***' --filter '+ matugen/***' --filter '+ electron-flags.conf' --filter '- *')

rsync $RSYNC_OPTS "${filter[@]}" ~/.config/ $DOTFILES_PATH/.config

echo "# Moving install script to project's root"

cp ./home/Documents/Scripts/install_dots.sh ./

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
