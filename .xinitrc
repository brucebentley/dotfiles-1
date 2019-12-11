#!/bin/sh

# Remap bindings
/usr/bin/setxkbmap -option 'caps:super'

session=${1:-i3}

case $session in
  i3|i3wm)
    /usr/bin/hsetroot -tile ~/Pictures/wallpaper/collections/0002.jpg
    exec i3
    ;;
  dwm)
    exec dwm
    ;;
  kde) exec startkde;;
  xfce|xfce4) exec startxfce4;;
  gnome|gnome-session) exec gnome-session;;
  *) exec $1;;
esac
