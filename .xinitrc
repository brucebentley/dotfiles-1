#!/bin/sh

if [[ -x $(command -v setxkbmap) ]]; then
        setxkbmap -option 'caps:super'
fi

if [[ -x $(command -v xcape) ]]; then
        xcape -e 'Super_L=Escape'
fi

if [[ -x $(command -v feh) ]]; then
        feh --randomize --bg-scale --no-xinerama ~/pictures/wallpaper
fi

if [[ -x $(command -v compton) ]]; then
        compton -b --config ~/.config/compton/compton.conf
fi

exec dwm
