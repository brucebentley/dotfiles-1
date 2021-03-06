#!/usr/bin/env zsh

bindkey -v

if tput cbt > /dev/null; then
	bindkey "$(tput cbt)" reverse-menu-complete
fi

zle-keymap-select zle-line-init () {
	local BLOCK_CURSOR=$'\033[6 q'
	local LINE_CURSOR=$'\033[2 q'
	
	if [ "$KEYMAP" = "main" ]; then
		printf "$BLOCK_CURSOR"
	else
		printf "$LINE_CURSOR"
	fi
}
zle -N zle-line-init
zle -N zle-keymap-select

fg-bg() {
	if [ "$#BUFFER" -eq 0 ]; then
		BUFFER="fg"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fg-bg
bindkey "^Z" fg-bg

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "^K" history-substring-search-up
bindkey "^J" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
