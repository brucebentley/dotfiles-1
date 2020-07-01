#!/usr/bin/env zsh

window_title_setup() {
	local CMD="${1:gs/$/\\$}"
	print -Pn "\033]0;$CMD:q\a"
}

window_title_preexec() {
	setopt EXTENDED_GLOB
	HISTCMD_LOCAL=$((++HISTCMD_LOCAL))

	local TRIMMED="${2[(wr)^(*=*|mosh|ssh|sudo)]}"
	if [[ -n $TMUX ]]; then
		window_title_setup "$TRIMMED"
	else
		window_title_setup "$(basename $PWD) > $TRIMMED"
	fi
}

window_title_precmd() {
	if [[ HISTCMD_LOCAL -eq 0 ]]; then
		window_title_setup "$(basename $PWD)"
	else
		local LAST=$(history | tail -1 | awk '{print $2}')
		if [[ -n $TMUX ]]; then
			window_title_setup "$LAST"
		else
			window_title_setup "$(basename $PWD) > $LAST"
		fi
	fi
}

window_title_init() {
	autoload -Uz add-zsh-hook

	HISTCMD_LOCAL=0

	add-zsh-hook precmd window_title_precmd
	add-zsh-hook preexec window_title_preexec
}

window_title_init "$@"
