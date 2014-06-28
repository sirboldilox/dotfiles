#!/bin/bash
#
# Dotfile instalation script.
#
# Writes symbolid links for all dotfiles in the
# selected group to the users $HOME directory

readonly SCRIPTNAME=$(basename $0)
readonly SCRIPTDIR=$(dirname $(readlink -f $0))


# Script Paramaters

DOTROOT=$SCRIPTDIR       # Dot file root
DOTGROUP=""              # Group to install
ARCHIVE="$DOTROOT/archived"

# Functions

usage() 
{
    echo "usage $SCRIPTNAME: [OPTIONS] GROUP"
}

eerror()
{
    echo "Error: $1"
    exit
}

# Check arguments

# Parse and setup arguments

    # check if dotfile exists
    # remove if symbolic link, archeive if not
    # install new symbolic link
install_group()
{
    readonly GROUP=$1
    readonly GROUPDIR="$DOTROOT/$1"

    echo "Installing Group $GROUP"

    for FILE in $GROUPDIR/*
      do
        install_dotfile $FILE
      done
}


# Installs the dotfile passed
#   $1: name of the dotfile in the group
install_dotfile()
{
    DOTFILE=$1
    DOTNAME=$(basename $1)
    DOTLINK="$HOME/.$DOTNAME"

    echo "->Installing $DOTNAME"    

    # Handle old file
    if [[ -h $DOTLINK ]]; then
    	echo " -> Removing: $DOTLINK"
        rm $DOTLINK
    elif [[ -e $DOTLINK ]]; then
        if [[ -d $DOTLINK ]]; then 
            echo " ->Archiving Directory $DOTLINK"
            mv $DOTLINK $ARCHIVE/$DOTNAME
        else
            echo " ->Archiving File: $DOTLINK"
            mv $DOTLINK $ARCHIVE/$DOTNAME
        fi
    fi

    echo " -> Linking $DOTNAME"
    ln -s $DOTFILE $DOTLINK 
}

# Main
if [[ $# < 1 ]]; then
    usage
    exit
fi

DOTGROUP=$1
mkdir -p $ARCHIVE

if [[ -d $DOTROOT/$DOTGROUP ]]; then
    install_group "$DOTGROUP"
else
    eerror "Folder: $DOTGROUP does not exist"
fi








