#!/bin/sh

/usr/bin/setxkbmap -option 'caps:super'
/usr/bin/feh --randomize --bg-scale --no-xinerama ~/Pictures/wallpaper/images
/usr/bin/compton -b --config ~/.config/compton/compton.conf

session=${1}

case $session in
  i3|i3wm) exec i3;;
  dwm) exec dwm;;
  kde) exec startkde;;
  *) exec $1;;
esac
