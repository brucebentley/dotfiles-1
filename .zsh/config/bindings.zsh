__EMANON[LINE_CURSOR]=$'\033[6 q'
__EMANON[BLOCK_CURSOR]=$'\033[2 q'

bindkey -v

KEYTIMEOUT=1

if tput cbt &> /dev/null; then
	bindkey "$(tput cbt)" reverse-menu-complete
fi

function zle-keymap-select zle-line-init {
	if [[ $KEYMAP == main ]]; then
		printf $__EMANON[LINE_CURSOR]
	else
		printf $__EMANON[BLOCK_CURSOR]
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
