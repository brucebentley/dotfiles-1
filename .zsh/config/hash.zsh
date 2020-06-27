#!/usr/bin/env zsh

local LOG=/var/log
local PORTAGE=/etc/portage
local LINUX=/usr/src/linux
local OVERLAY=/var/db/repos
local CODE=~/Code

test -d "$LOG" && hash -d log="$LOG"
test -d "$PORTAGE" && hash -d portage="$PORTAGE"
test -d "$LINUX" && hash -d linux="$LINUX"
test -d "$OVERLAY" && hash -d overlay="$OVERLAY"
test -d "$CODE" && hash -d code="$CODE"
