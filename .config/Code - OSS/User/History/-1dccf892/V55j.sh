#!/bin/bash
#Document Folders Copy
#-a: Archive mode, which preserves permissions, timestamps, and recursively copies directories.
#-v: Verbose, to show progress.
#--exclude: Specifies each folder or file to exclude from the copy.
#--include: Specifies each folder or file to include from the fetched path.
include=(--include 'Hyprlock Assets/' --include 'Scripts/' --include 'Wallpapers/' --exclude '*/')

rsync -av "${include[@]}" ~/Documents/ ~/Documents/dotfiles/Documents_Folder 

#.config Folders Copy