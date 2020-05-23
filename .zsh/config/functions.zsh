function ag() {
	emulate -L zsh

	command ag --pager="less -iFMRSX" --color-path=34\;3 --color-line-number=35 --color-match=35\;1\;4 "$@"
}

function vifm() {
	emulate -L zsh

	if command -v ueberzug > /dev/null; then
		export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"
		rm "$FIFO_UEBERZUG" 2> /dev/null
		mkfifo "$FIFO_UEBERZUG"
		trap "rm "$FIFO_UEBERZUG" 2> /dev/null pkill -P $$ 2> /dev/null" EXIT
		tail -f "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash &

		command vifm "$@"
		rm "$FIFO_UEBERZUG" 2> /dev/null
		pkill -P $$ 2> /dev/null
		unset FIFO_UEBERZUG
	else
		command vifm
	fi
}

function fd() {
	local DIR
	DIR=$(find -type d 2> /dev/null | fzf --color=16 --no-multi --preview='test -n "{}" && ls {}' -q "$*") && cd "$DIR"
}

function fh() {
	print -z $(fc -l 1 | fzf --color=16 --no-multi --tac -q "$*" | sed 's/ *[0-9]*\*\{0,1\} *//')
}

function scratch() {
	local SCRATCH=$(mktemp -d)
	echo 'Spawing subshell in scratch directory:'
	echo "  $SCRATCH"
	(cd $SCRATCH; zsh)
	echo "Removing scratch directory"
	rm -r "$SCRATCH"
}

function ssh() {
	emulate -L zsh

	if [[ -z "$@" ]]; then
		command ssh dev
	else
		local LOCAL_TERM=$(echo -n "$TERM" | sed -e s/tmux/screen/)
		command env TERM=$LOCAL_TERM ssh "$@"
	fi
}

function tmux() {
	emulate -L zsh

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
		if ! command ag --silent "$DIGEST" ~/..tmux.digests 2> /dev/null; then
			cat .tmux
			read -k 1 -r 'REPLY?Trust (and run) this .tmux file? (t = trust, otherwise = skip) '
			echo
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

function regmv() {
	emulate -L zsh

	if [ $# -lt 2 ]; then
		echo "  Usage: regmv 'regex' file(s)"
		echo "  Where:       'regex' should be of the format '/find/replace/'"
		echo "Example: regmv '/\.tif\$/.tiff/' *"
		echo "   Note: Must quote/escape the regex otherwise \"\.\" becomes \".\""
		return 1
	fi
	local REGEX="$1"
	shift
	while [ -n "$1" ]
	do
		local NEWNAME=$(echo "$1" | sed "s${REGEX}g")
		if [ "${NEWNAME}" != "$1" ]; then
			mv -i -v "$1" "$NEWNAME"
		fi
		shift
	done
}

function jump() {
	emulate -L zsh
	if [ $# -eq 0 ]; then
		fd
	else
		local DIR="${*%%/}"
		if [ $(hash -d|cut -d= -f1 | command ag -c "^${DIR}\$") = 0 ]; then
			fd "$*"
		else
			cd ~"$DIR"
		fi
	fi
}

function _jump_complete() {
	emulate -L zsh

	local COMPLETIONS
	COMPLETIONS="$(hash -d|cut -d= -f1)"
	reply=( "${(ps:\n:)COMPLETIONS}" )
}

compctl -f -K _jump_complete jump

function subtree() {
	tree -a --prune -P "$@"
}
