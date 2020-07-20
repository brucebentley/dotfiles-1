#!/bin/sh

if [ -x "$(command -v setxkbmap)" ] && [ -x "$(command -v xcape)" ]; then
	setxkbmap -layout "us+symbols(xcape-special)" \
		  -keycodes "evdev+keycodes(xcape-special)" \
		  -option "caps:super,shift:both_shiftlock" -print | \
		  xkbcomp -I"$HOME/.config/setxkbmap" - "${DISPLAY%%.*}" > /dev/null 2>&1

	xcape -e "Hyper_R=space;Super_L=Escape"
fi

if command -v xwallpaper > /dev/null; then
	picture=$(awk -v min=1 -v max=21 "BEGIN{srand(); print int(min+rand()*(max-min+1))}")
	path=$(printf "$HOME/Pictures/wallpaper/%04d.jpg\n" "$picture")
	xwallpaper --zoom "$path"
fi

if command -v picom > /dev/null; then
	picom -b --config ~/.config/picom/picom.conf
fi

if command -v unclutter > /dev/null; then
	unclutter --idle 1 &
fi

case $1 in
	dwm)
		if command -v slstatus > /dev/null; then
			slstatus &
		fi
		exec dwm
		;;
	kde)
		exec startkde
		;;
	*)
		exec "$1"
		;;
esac
