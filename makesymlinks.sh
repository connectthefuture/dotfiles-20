#!/usr/bin/env bash
#   ______________________________________________________________________

#   DOTFILES SETUP SCRIPT
#                              written by Jonas Sjöberg for *personal* use
#                                                 Last updated: 2016-04-23
#   ______________________________________________________________________

#   Should only ever need to be executed after a clean reinstall of the home
#   directory.  Replaces the standard "/home/user/.configfile"-files with
#   symlinks to files kept under version control in this here repository.
#   Some error checks are performed but please note that I WILL NOT take any
#   responsability for anything you might do with this script. Be careful.
#

# USER CONFIGURABLE VARIABLES
# These are the dotfiles that will be installed.
CONFIGFILES="bashrc bash_aliases vimrc vim zshrc oh-my-zsh gitconfig zshenv conkyrc gitignore-global inputrc tmux.conf"

# Be verbose, print debug information.
VERBOSE="true"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set -e                         # Exit immediately if a command returns non-zero.

# Set useful variables.
DOTFILES_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TEMP_DIR=$(mktemp -d /tmp/dotfiles.XXXXXX)
ts="$(date +%F_%H-%M-%S)"
BACKUP_ARCHIVE="${HOME}/dotfiles_${ts}.tar.gz"


# Print info to stdout if VERBOSE is set.
print_info()
{
    [ "$VERBOSE" ] && printf "* %s ..\n" "$1"
}


# Print error and exit.
die()
{
    [ ! -z "$1" ] && printf "[!] ERROR: %s\n" "$1" 1>&2
    exit 1
}


[ "$VERBOSE" ] && cat << EOF
────────────────────────────────────────────────────────────────────────────────
  Dotfiles setup script
  =====================

* started with root: $DOTFILES_ROOT

* will symlink from source: $HOME
         .. to destination: $DOTFILES_ROOT
  .. acting on these files: $CONFIGFILES

* archiving any existing to: $BACKUP_ARCHIVE
────────────────────────────────────────────────────────────────────────────────

EOF

cd "$HOME"

# Run through the list of configfiles. Check if the source file (THIS_SRC)
# exists and is an ordinary file. Then check if it is a symbolic link, which
# is deleted. If it isn't a symlink, it is moved to a temporary directory, which
# is created if need be.
# Next, check if the destination file ($THIS_DST) exists. If it does, go ahead
# and create a symlink from source to destination.
for file in $CONFIGFILES
do
    dotfile=".${file}"
    THIS_SRC="${HOME}/${dotfile}"            # this file is a link ..
    THIS_DST="${DOTFILES_ROOT}/${file}"      # .. to this file

    if [ -e "$THIS_SRC" ]
    then
        [ ! -d $TEMP_DIR ] && die "Unable to create temporary folder"

        if [ -L "$THIS_SRC" ]
        then
            print_info "Removing existing symlink \"${dotfile}\""
            rm -v -- "$THIS_SRC"
        else

            print_info "Moving \".${file}\" out of the way"
            mv -vni -- "${THIS_SRC}" "${TEMP_DIR}"
        fi
    fi

    # Check that file is in repo directory.
    if [ ! -e "$THIS_DST" ]
    then
        die "\"${THIS_DST}\" does not exist"
    else
        print_info "Creating symlink"
        ln -vsi -- "${THIS_DST}" "${THIS_SRC}"
    fi
done

print_info "done"

# Create a backup archive if needed. First check if the temporary directory
# exists. If it does, we can assume it contains our old dotfiles.
# Create a zipped tar archive with a date and timestamp in the filename.
# Then go ahead aand remove the temporary directory and files.
if [ -d "${TEMP_DIR}" ]
then
    print_info "Archiving the old dotfiles"

    # This assumes more than a minute passes between runs .. file exists error?
    find "${TEMP_DIR}" -maxdepth 1 -type f -name ".*" -exec tar vczf "$BACKUP_ARCHIVE" "{}" +

    print_info "Done"
    print_info "Removing temporary files"
    rm -vrf -- "${TEMP_DIR}"

    print_info "Done"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if command -v thunar >/dev/null
then
    # Symlink thunar custom actions configuration file
    THUNARCONF_SRC="${HOME}/.config/Thunar/uca.xml"       # this file is a link ..
    THUNARCONF_DST="${DOTFILES_ROOT}/thunar-custom.xml"   # .. to this file
    THUNARCONF_BAK="${THUNARCONF_SRC}_$(date +%F_%H%M%S)"

    if [ ! -f "$THUNARCONF_DST" ]         # is the repo file in place?
    then
        die "${THUNARCONF_DST} doesn't exist!"
        exit 1
    fi

    if [ -f "$THUNARCONF_SRC" ]           # is the config file already in place?
    then
        if [ -L "$THUNARCONF_SRC" ]       # is the config file a symlink?
        then
            # It's a symlink. Just remove it.
            print_info "Removing symlink ${THUNARCONF_SRC}"
            rm -v -- "$THUNARCONF_SRC"
        else
            # Not a symlink. Probably default config file.
            print_info "Moving existing file out of the way"
            mv -vni -- "$THUNARCONF_SRC" "$THUNARCONF_BAK"
        fi
    fi

    # Create symlink from "$THUNARCONF_DST" to "$THUNARCONF_SRC".
    print_info "Creating symlink"
    ln -vsi -- "$THUNARCONF_DST" "$THUNARCONF_SRC"
    echo ""

    print_info "Done"
else
    print_info "Thunar doesn't seem to be installed. Skipping"
fi


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Create symlink to zsh theme
print_info "symlinking zsh theme"
OMZ_THEMES="${DOTFILES_ROOT}/oh-my-zsh/themes"

if [ -d "$OMZ_THEMES" ]
then
    ln -vsi -- "${DOTFILES_ROOT}/jonas.zsh-theme" "${OMZ_THEMES}/jonas.zsh-theme"
else
    die "${OMZ_THEMES} doesn't exist. Make sure oh-my-zsh is installed."
fi
