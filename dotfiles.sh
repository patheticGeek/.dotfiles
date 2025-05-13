#!/usr/bin/env bash

export STOW_DIR=$HOME/.dotfiles
export FOLDERS_FILE=$STOW_DIR/dotfiles_folders

get_stow_folders() {
    cat $FOLDERS_FILE
}
set_stow_folders() {
    echo ${@} > $FOLDERS_FILE
}

stowFolders="$(get_stow_folders)"
stowFlags=""
personal=0

addFolder=
addFile=

_help() {
    echo """
dotfiles - for managing my dotfiles

COMMAND
    dotfiles [setup|remove|update] [-d|--dry]
    dotfiles [add|delete] FOLDER FILE
    dotfiles [add-folder|delete-folder] FOLDER
    dotfiles [-h|--help|help]

DESCRIPTION
    dotfiles command is supposed to be used to backup and sync your dotfiles using git & stow.

OPTIONS
    setup, remove, update [-d|--dry]
        Pretty self explanatory.

    add FOLDER FILE
        Add an existing FILE. Will move FILE to the FOLDER in dotfiles with correct path and link it.

    delete FOLDER FILE
        Stop tracking FILE. Will move the FILE to its location and restow the FOLDER removing the linking.

    add-folder FOLDER
        Adds FOLDER to dotfiles_folders

    delete-folder FOLDER
        Delete FOLDER from dotfiles_folders

    -h, --help, help
        Will print this.

    -d, --dry
        If present, this only does a dry run and outputs what will happen.
"""
}

_setup() {
    echo Setting up - $stowFolders

    stow $stowFlags --adopt -S $stowFolders

    echo "✨ All done"
}

_remove() {
    echo Removing - $stowFolders

    stow $stowFlags -D $stowFolders

    echo "✨ All done"
}

_update() {
    echo Updating - $stowFolders

    stow $stowFlags --adopt -R $stowFolders

    echo "✨ All done"
}

createIfNotExists() {
    test -d ${1} || mkdir -p ${1}
}

addDotfilesFolder() {
    local dotfilesFolders=$(get_stow_folders)
    if [[ $dotfilesFolders == *"${1}"* ]];
    then
        echo ${1} already present in $FOLDERS_FILE
    else
        set_stow_folders "$(get_stow_folders) ${1}"
        echo ${1} added in $FOLDERS_FILE
    fi
}
removeDotfilesFolder() {
    local dotfilesFolders=($(get_stow_folders))
    local toDelete=${1}
    if [[ $dotfilesFolders == *"${1}"* ]];
    then
        set_stow_folders "${dotfilesFolders[@]/$toDelete}"
        echo ${1} removed from $FOLDERS_FILE
    else
        echo ${1} not in $FOLDERS_FILE
    fi
}

_add() {
    if [[ -z $addFile ]]; then echo Require the FILE argument && exit 1; fi;
    if [[ -z $addFolder ]]; then echo Require the FOLDER argument && exit 1; fi;

    local relativePathToHome=$(realpath --relative-to="$HOME" $addFile)
    local filePath=$HOME/$relativePathToHome
    if ! [[ -f $filePath ]]; then echo File $filePath does not exist && exit 1; fi;

    local moveTo=$STOW_DIR/$addFolder/$relativePathToHome

    # Move the file in the dotfiles
    echo Moving $filePath to $moveTo
    createIfNotExists $(dirname $moveTo)
    mv $filePath $moveTo

    # Setup that folder to link the file
    addDotfilesFolder $addFolder
    stowFolders=($(echo $addFolder))
    _setup
}

_delete() {
    if [[ -z $addFile ]]; then echo Require the FILE argument && exit 1; fi;
    if [[ -z $addFolder ]]; then echo Require the FOLDER argument && exit 1; fi;

    local filePath=$STOW_DIR/$addFolder/$addFile
    if ! [[ -f $filePath ]]; then echo File $filePath does not exist && exit 1; fi;

    local relativePathToHome=$(realpath --relative-to="$STOW_DIR/$addFolder" $filePath)
    local moveTo=$HOME/$relativePathToHome

    # Move the file from dotfiles to correct path
    if [[ -f $filePath ]]; then echo Deleting $moveTo; rm $moveTo; fi;
    echo Moving $filePath to $moveTo
    mv $filePath $moveTo

    # Setup that folder once again
    stowFolders=($(echo $addFolder))
    _setup
}

_addFolder() {
    addDotfilesFolder $addFolder
    # Setup that folder to link the file
    stowFolders=($(echo $addFolder))
    _setup
}
_deleteFolder() {
    removeDotfilesFolder $addFolder
    # Remove that folder to unlink files
    stowFolders=($(echo $addFolder))
    _remove
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
            add-folder)
                fnToRun="_addFolder"
                shift
            ;;
            delete-folder)
                fnToRun="_deleteFolder"
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

    # echo Running $fnToRun with folders=$stowFolders flags=$stowFlags addFolder=$addFolder addFile=$addFile

    $fnToRun # Run whatever needs to run

    return 0
}

main "${@:-}"
