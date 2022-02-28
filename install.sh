#!/usr/bin/env zsh

STOW_FOLDERS=alacritty,kitty,neofetch,others,themes,vim,zsh

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow -D $folder
    stow $folder
done
