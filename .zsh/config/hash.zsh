# Shortcuts for paths.
# (eg. cd ~www; but also, `jump www`/`j www`)
# For a full list, run `hash -d` (alias `d`).

# test -d $SOME_DIR && hash -d $SHORTCUT=$SOME_DIR

# Work machine:
local BIN=~/bin
local CODE=~/code
local COMPILER=~/.vim/after/compiler
local DOTFILES=~/dotfiles
local LINUX=/usr/src/linux
local OVERLAY=/var/db/repos
local PORTAGE=/etc/portage

test -d "$BIN" && hash -d bin="$BIN"
test -d "$CODE" && hash -d code="$CODE"
test -d "$COMPILER" && hash -d compiler="$COMPILER"
test -d "$DOTFILES" && hash -d dots="$DOTFILES"
test -d "$LINUX" && hash -d linux="$LINUX"
test -d "$OVERLAY" && hash -d overlay="$OVERLAY"
test -d "$PORTAGE" && hash -d portage="$PORTAGE"
