#!/bin/sh

# Remap bindings
/usr/bin/setxkbmap -option 'caps:super'

session=${1:-i3}

case $session in
  i3|i3wm)
    /usr/bin/hsetroot -fill ~/Pictures/wallpaper/abstract/0051.jpg
    exec i3
    ;;
  dwm)
    /usr/bin/hsetroot -fill ~/Pictures/wallpaper/pacman-gruvbox.png
    exec dwm
    ;;
  kde) exec startkde;;
  xfce|xfce4) exec startxfce4;;
  gnome|gnome-session) exec gnome-session;;
  *) exec $1;;
esac
