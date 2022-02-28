#!/usr/bin/env zsh

STOW_FOLDERS=${STOW_FOLDERS:=alacritty,fish,kitty,neofetch,others,vim,zsh,tmux}

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo "Setting up ${folder}"
    stow -D $folder
    stow $folder
done

echo "✨ All done"
