#!/bin/sh

# Remap bindings
/usr/bin/setxkbmap -option 'caps:super'

session=${1:-i3}

case $session in
  i3|i3wm)
    exec i3
    ;;
  dwm)
    exec dwm
    ;;
  kde) exec startkde;;
  *) exec $1;;
esac
