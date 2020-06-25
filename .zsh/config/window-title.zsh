#!/usr/bin/env zsh

autoload -Uz add-zsh-hook

function -set-tab-and-window-title() {
	emulate -L zsh

	local CMD="${1:gs/$/\\$}"
	print -Pn "\033]0;$CMD:q\a"
}

function -update-window-title-preexec() {
	emulate -L zsh

	setopt EXTENDED_GLOB
	HISTCMD_LOCAL=$((++HISTCMD_LOCAL))

	local TRIMMED="${2[(wr)^(*=*|mosh|ssh|sudo)]}"
	if [[ -n $TMUX ]]; then
		-set-tab-and-window-title "$TRIMMED"
	else
		-set-tab-and-window-title "$(basename $PWD) > $TRIMMED"
	fi
}
add-zsh-hook preexec -update-window-title-preexec

HISTCMD_LOCAL=0
function -update-window-title-precmd() {
	emulate -L zsh

	if [[ HISTCMD_LOCAL -eq 0 ]]; then
		-set-tab-and-window-title "$(basename $PWD)"
	else
		local LAST=$(history | tail -1 | awk '{print $2}')
		if [[ -n $TMUX ]]; then
			-set-tab-and-window-title "$LAST"
		else
			-set-tab-and-window-title "$(basename $PWD) > $LAST"
		fi
	fi
}
add-zsh-hook precmd -update-window-title-precmd
