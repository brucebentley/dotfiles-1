#!/usr/bin/env zsh

jump() {
	local DIR="${*%%/}"
	cd ~"$DIR"
}

scratch() {
	local SCRATCH="$(mktemp -d)"
	echo "Spawing subshell in scratch directory:"
	echo "$SCRATCH"
	(cd "$SCRATCH" && zsh)
	echo "Removing scratch directory"
	rm -rf "$SCRATCH"
}

tmux() {
	local SOCK_SYMLINK="$HOME/.ssh/ssh_auth_sock"
	if [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ]; then
		ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
	fi

	if [ -n "$*" ]; then
		env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"
		return
	fi

	if [ -x .tmux ]; then
		local DIGEST="$(openssl sha -sha512 .tmux)"
		if ! grep --silent "$DIGEST" ~/..tmux.digests 2> /dev/null; then
			cat .tmux
			read -k 1 -r "REPLY? Trust (and run) this .tmux file? (t = trust, otherwise = skip) "
			if [[ "$REPLY" =~ ^[Tt]$ ]]; then
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
		tail -f "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash &!

		command vifm "$@"

		rm "$FIFO_UEBERZUG" 2> /dev/null
		pkill -P $$ 2> /dev/null
		unset FIFO_UEBERZUG
	else
		command vifm "$@"
	fi
}

xinit() {
	vt=$(tty | sed "s/\/dev\/tty/vt/")
	command xinit "$1" -- "$vt"
}
