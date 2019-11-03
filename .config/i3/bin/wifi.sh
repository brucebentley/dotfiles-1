#!/bin/bash

#------------------------------------------------------------------------
if [[ -z "$INTERFACE" ]] ; then
    INTERFACE="${BLOCK_INSTANCE:-wlan0}"
fi
#------------------------------------------------------------------------

# As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
# connection (think desktop), the corresponding block should not be displayed.
[[ ! -d /sys/class/net/${INTERFACE}/wireless ]] && exit

# If the wifi interface exists but no connection is active, "down" shall be displayed.
if [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]]; then
    echo "down"
    echo "down"
    exit
fi

#------------------------------------------------------------------------

QUALITY=$(ag $INTERFACE </proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

#------------------------------------------------------------------------

echo $QUALITY% # full text
echo $QUALITY% # short text
