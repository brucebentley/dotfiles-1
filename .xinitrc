#!/bin/sh

if command -v slstatus > /dev/null; then
	slstatus &
fi

if command -v setxkbmap xcape > /dev/null; then
	setxkbmap -layout "us+symbols(xcape-special)" \
		  -keycodes "evdev+keycodes(xcape-special)" \
		  -option "caps:super,shift:both_shiftlock" -print | \
		  xkbcomp -I"$HOME/.config/setxkbmap" - "${DISPLAY%%.*}" > /dev/null 2>&1

	xcape -e "Hyper_R=space;Super_L=Escape"
fi

if command -v xwallpaper > /dev/null; then
	picture=(~/Pictures/wallpaper/*)
	xwallpaper --zoom ${picture[RANDOM % ${#picture[@]}]}
fi

if command -v picom > /dev/null; then
	picom -b --config ~/.config/picom/picom.conf
fi

if command -v unclutter > /dev/null; then
	unclutter --idle 1 &
fi

if command -v dwm > /dev/null; then
	exec dwm
fi
