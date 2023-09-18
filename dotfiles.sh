#!/usr/bin/env bash

export STOW_DIR=~/.dotfiles

stowFolders=(common bash alacritty fish kitty neofetch others vim zsh tmux gestures)
stowFlags=""
personal=0

addFolder=
addFile=

_help() {
    echo """
COMMAND
    dotfiles [setup|remove|update] [--folders VALUE] [-p|--personal] [-d|--dry]
    dotfiles [add|delete] FOLDER FILE
    dotfiles [-h|--help|help]

DESCRIPTION
    dotfiles command is supposed to be used to backup and sync your dotfiles using git & stow.

OPTIONS
    setup, remove, update
        Pretty self explanatory.

    add
        Add an existing FILE. Will move FILE to the FOLDER in dotfiles with correct path and link it.

    delete
        Stop tracking FILE. Will move the FILE to its location and restow the FOLDER removing the linking.

    -h, --help, help
        Will print this.

    --folders VALUE
        Takes a comma seperated list of folders that are to be used.

    -p, --personal 
        If present setup the personal folder also.

    -d, --dry
        If present, this only does a dry run and outputs what will happen.
"""
}

_setup() {
    echo Setting up - $stowFolders

    stow $stowFlags --adopt --no-folding -S $stowFolders

    echo "✨ All done"
}

_remove() {
    echo Removing - $stowFolders

    stow $stowFlags --no-folding -D $stowFolders

    echo "✨ All done"
}

_update() {
    echo Updating - $stowFolders

    stow $stowFlags --adopt --no-folding -R $stowFolders

    echo "✨ All done"
}

createIfNotExists() {
    test -d ${1} || mkdir -p ${1}
}

_add() {
    if [[ -z $addFile ]]; then echo Require the FILE argument && exit 1; fi;
    if [[ -z $addFolder ]]; then echo Require the FOLDER argument && exit 1; fi;
    if ! [[ -f $addFile ]]; then echo File does not exist && exit 1; fi;

    local relativePathToHome=$(realpath --relative-to="$HOME" $addFile)
    local moveTo=~/.dotfiles/$addFolder/$relativePathToHome

    # Move the file in the dotfiles
    echo Moving $addFile to $moveTo
    createIfNotExists $(dirname $moveTo)
    mv $addFile $moveTo

    # Setup that folder to link the file
    stowFolders=($(echo $addFolder))
    _setup
}

_delete() {
    if [[ -z $addFile ]]; then echo Require the FILE argument && exit 1; fi;
    if [[ -z $addFolder ]]; then echo Require the FOLDER argument && exit 1; fi;

    local filePath=$HOME/.dotfiles/$addFolder/$addFile
    if ! [[ -f $filePath ]]; then echo File does not exist && exit 1; fi;

    local relativePathToHome=$(realpath --relative-to="$HOME/.dotfiles/$addFolder" $filePath)
    local moveTo=$HOME/$relativePathToHome

    # Move the file from dotfiles to correct path
    echo Moving $filePath to $moveTo
    if [[ -f $filePath ]]; then rm $moveTo; fi;
    mv $filePath $moveTo

    # Setup that folder once again
    stowFolders=($(echo $addFolder))
    _setup
}

main() {
    local position=0
    local fnToRun="_help"

    while [[ "${#}" -gt 0 ]]; do
        case "${1}" in
            -h|--help|help)
                _help
                exit 0
            ;;
            setup)
                fnToRun="_setup"
                shift
            ;;
            remove)
                fnToRun="_remove"
                shift
            ;;
            update)
                fnToRun="_update"
                shift
            ;;
            add)
                fnToRun="_add"
                shift
            ;;
            delete)
                fnToRun="_delete"
                shift
            ;;
            -f|--folders)
                folders=${2}
                stowFolders=($(echo $folders | sed "s/,/ /g"))
                shift 2
            ;;
            -p|--personal)
                personal=1
                shift
            ;;
            -d|--dry)
                stowFlags="-nv"
                shift
            ;;
            *)
                case "${position}" in
                    0)
                        addFolder="${1}"
                        position=1
                        shift
                    ;;
                    1)
                        addFile="${1}"
                        position=2
                        shift
                    ;;
                esac
            ;;
        esac
    done

    [[ $personal -gt 0 ]] && stowFolders+=(personal)

    stowFolders="${stowFolders[@]}" # Fix iteration shit in bash

    # echo Running $fnToRun with folders=$stowFolders flags=$stowFlags addFolder=$addFolder addFile=$addFile

    $fnToRun # Run whatever needs to run

    return 0
}

main "${@:-}"
