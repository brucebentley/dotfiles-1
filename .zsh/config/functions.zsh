#!/usr/bin/env zsh

colortest() {
	THEME=$(head -1 "$HOME/.zsh/.base16")
	THEME_FILE=$HOME/.zsh/colors/base16-$THEME.sh

	if [[ -f $THEME_FILE ]]; then
		source $THEME_FILE
		eval $(awk '/^color00=/,/^$/ {print}' $THEME_FILE | sed 's/#.*//')
	else
		printf "No theme file %s found\n" $THEME_FILE
	fi;

	ansi_mappings=(
		Black
		Red
		Green
		Yellow
		Blue
		Magenta
		Cyan
		White
		Bright_Black
		Bright_Red
		Bright_Green
		Bright_Yellow
		Bright_Blue
		Bright_Magenta
		Bright_Cyan
		Bright_White
	)

	colors=(
		base00
		base08
		base0B
		base0A
		base0D
		base0E
		base0C
		base05
		base03
		base08
		base0B
		base0A
		base0D
		base0E
		base0C
		base07
		base09
		base0F
		base01
		base02
		base04
		base06
	)

	for padded_value in `seq -w 0 21`; do
		color_variable="color${padded_value}"
		eval current_color=\$${color_variable}
		current_color=$(echo ${current_color//\//} | tr '[:lower:]' '[:upper:]')
		non_padded_value=$((10#$padded_value))
		base16_color_name=${colors[$non_padded_value]}
		current_color_label=${current_color:-unknown}
		ansi_label=${ansi_mappings[$non_padded_value]} 
		block=$(printf "\x1b[48;5;${non_padded_value}m___________________________")
		foreground=$(printf "\x1b[38;5;${non_padded_value}m$color_variable")
		printf "%s %s %s %-30s %s\x1b[0m\n" $foreground $base16_color_name $current_color_label ${ansi_label:-""} $block
	done;
}

jump() {
	local DIR="${*%%/}"
	cd ~"$DIR"
}

scratch() {
	local SCRATCH=$(mktemp -d)
	echo 'Spawing subshell in scratch directory:'
	echo "  $SCRATCH"
	(cd $SCRATCH && zsh)
	echo "Removing scratch directory"
	rm -rf "$SCRATCH"
}

tmux() {
	local SOCK_SYMLINK=~/.ssh/ssh_auth_sock
	if [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ]; then
		ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
	fi

	if [[ -n "$@" ]]; then
		env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"
		return
	fi

	if [ -x .tmux ]; then
		local DIGEST="$(openssl sha -sha512 .tmux)"
		if ! grep --silent "$DIGEST" ~/..tmux.digests 2> /dev/null; then
			cat .tmux
			read -k 1 -r 'REPLY? Trust (and run) this .tmux file? (t = trust, otherwise = skip) '
			if [[ $REPLY =~ ^[Tt]$ ]]; then
				echo "$DIGEST" >> ~/..tmux.digests
				./.tmux
				return
			fi
		else
			./.tmux
			return
		fi
	fi

	local SESSION_NAME=$(basename "${$(pwd)//[.:]/_}")
	env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
}

vifm() {
	if command -v ueberzug > /dev/null; then
		export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"
		rm "$FIFO_UEBERZUG" 2> /dev/null
		mkfifo "$FIFO_UEBERZUG"
		trap "rm "$FIFO_UEBERZUG" 2> /dev/null && pkill -P $$ 2> /dev/null" EXIT
		tail -f "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash &

		command vifm "$@"

		rm "$FIFO_UEBERZUG" 2> /dev/null
		pkill -P $$ 2> /dev/null
		unset FIFO_UEBERZUG
	else
		command vifm
	fi
}

xinit() {
	command xinit $1 -- $(tty | sed 's/\/dev\/tty/vt/')
}
