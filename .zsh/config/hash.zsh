local LINUX=/usr/src/linux
local LOG=/var/log
local OVERLAY=/var/db/repos
local PORTAGE=/etc/portage

test -d "$LINUX" && hash -d linux="$LINUX"
test -d "$LOG" && hash -d log="$LOG"
test -d "$OVERLAY" && hash -d overlay="$OVERLAY"
test -d "$PORTAGE" && hash -d portage="$PORTAGE"
