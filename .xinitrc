#!/bin/sh

# Set wallpaper
/usr/bin/hsetroot -full ~/Pictures/pacman-gruvbox.png

# Remap bindings
/usr/bin/setxkbmap -option 'caps:super'

session=${1:-i3}

case $session in
  i3|i3wm) exec i3;;
  kde) exec startkde;;
  xfce|xfce4) exec startxfce4;;
  gnome|gnome-session) exec gnome-session;;
  *) exec $1;;
esac
