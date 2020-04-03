# Shortcuts for paths.
# (eg. cd ~www; but also, `jump www`/`j www`)
# For a full list, run `hash -d` (alias `d`).

# test -d $SOME_DIR && hash -d $SHORTCUT=$SOME_DIR

# Work machine:
local DOTFILES=~/dotfiles
local PORTAGE=/etc/portage
local LINUX=/usr/src/linux

test -d "$DOTFILES" && hash -d dots="$DOTFILES"
test -d "$LINUX" && hash -d linux="$LINUX"
test -d "$PORTAGE" && hash -d portage="$PORTAGE"
