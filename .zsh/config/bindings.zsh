#!/usr/bin/env zsh

bindkey -v

KEYTIMEOUT=1

if tput cbt &> /dev/null; then
	bindkey "$(tput cbt)" reverse-menu-complete
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

function zle-keymap-select zle-line-init {
	if [[ $KEYMAP == main ]]; then
		printf $__USER[LINE_CURSOR]
	else
		printf $__USER[BLOCK_CURSOR]
	fi
}
zle -N zle-line-init
zle -N zle-keymap-select

function fg-bg() {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER="fg"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fg-bg
bindkey '^Z' fg-bg
