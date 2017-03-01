#!/usr/bin/env bash

# All credits goes to the blog post "Image diffs with git" by Aki Koskinen at:
#
#     http://www.akikoskinen.info/image-diffs-with-git/
#
#
# - Specify a global '.gitattributes' file:
#
#     $ git config --global core.attributesfile '~/.gitattributes'
#
# - Add file extensions to considar as image files:
#
#     $ cat ~/.gitattributes 
#     *.gif diff=image
#     *.jpg diff=image
#     *.png diff=image
#
# - Specify a diff command to run for the 'image' files:
#
#     $ git config --global diff.image.command '~/dotfiles/git/git-imgdiff.sh'
#

# TODO: Add test for 'compare' available on the system, provided by ImageMagick.
compare "$2" "$1" png:- | montage -geometry +4+4 "$2" - "$1" png:- | display -title "$1" -
# compare "$2" "$1" png:- | montage -resize 50% -geometry +4+4 "$2" - "$1" png:- | display -title "$1" -
