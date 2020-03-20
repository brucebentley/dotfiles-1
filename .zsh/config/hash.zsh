# Shortcuts for paths.
# (eg. cd ~www; but also, `jump www`/`j www`)
# For a full list, run `hash -d` (alias `d`).

# test -d $SOME_DIR && hash -d $SHORTCUT=$SOME_DIR

# Work machine:
local DOTFILES=~/dotfiles

test -d "$DOTFILES" && hash -d "$DOTFILES"
