#!/usr/bin/env sh

# Kill all compton processes
killall -q compton

# Wait for all processes to shutdown
while pgrep -x compton > /dev/null; do sleep 1; done

# Launch compton in background using config file
# /home/emanon/.config/compton/compton.conf
compton -b --config /home/emanon/.config/compton/compton.conf

echo "Compton launched successfully..."
