#!/usr/bin/env zsh

STOW_FOLDERS=${STOW_FOLDERS:=common,bash,alacritty,fish,kitty,neofetch,others,vim,zsh,tmux,gestures}

if [ $PERSONAL ]
then
    STOW_FOLDERS=$STOW_FOLDERS,personal
fi

STOW_PACKAGES=$(echo $STOW_FOLDERS | sed "s/,/ /g")

echo Running for $STOW_PACKAGES

STOW_FLAGS=${STOW_FLAGS:="-nv"}

stow $(echo $STOW_FLAGS) --adopt -S $(echo $STOW_PACKAGES)

echo "✨ All done"
