#!/bin/sh

if [ -x "$(command -v setxkbmap)" ]; then
        setxkbmap -option 'caps:super'
fi

if [ -x "$(command -v feh)" ]; then
        feh --randomize --bg-scale --no-xinerama ~/Pictures/wallpaper
fi

if [ -x "$(command -v compton)" ]; then
        compton -b --config ~/.config/compton/compton.conf
fi


session=${1}

case $session in
  i3|i3wm) exec i3;;
  dwm) exec dwm;;
  kde) exec startkde;;
  *) exec $1;;
esac
