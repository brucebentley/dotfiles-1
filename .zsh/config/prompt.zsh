__EMANON[ITALIC_ON]=$'\033[3m'
__EMANON[ITALIC_OFF]=$'\033[23m'

DISABLE_UPDATE_PROMPT=true

RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f"
SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

setopt PROMPT_SUBST

function -set-tab-and-window-title() {
	emulate -L zsh

	local CMD="${1:gs/$/\\$}"
	print -Pn "\033]0;$CMD:q\a"
}

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

typeset -F SECONDS
function -record-start-time() {
	emulate -L zsh

	ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}
add-zsh-hook preexec -record-start-time

function -report-start-time() {
	emulate -L zsh

	if [ $ZSH_START_TIME ]; then
		local DELTA=$(($SECONDS - $ZSH_START_TIME))
		local DAYS=$((~~($DELTA / 86400)))
		local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
		local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
		local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
		local ELAPSED=''
		test "$DAYS" != '0' && ELAPSED="${DAYS}d"
		test "$HOURS" != '0' && ELAPSED="${ELAPSED}${HOURS}h"
		test "$MINUTES" != '0' && ELAPSED="${ELAPSED}${MINUTES}m"
		if [ "$ELAPSED" = '' ]; then
			SECS="$(print -f "%.2f" $SECS)s"
		elif [ "$DAYS" != '0' ]; then
			SECS=''
		else
			SECS="$((~~$SECS))s"
		fi
		ELAPSED="${ELAPSED}${SECS}"
		RPROMPT="%F{cyan}%{$__EMANON[ITALIC_ON]%}${ELAPSED}%{$__EMANON[ITALIC_OFF]%}%f $RPROMPT_BASE"
		unset ZSH_START_TIME
	else
		RPROMPT="$RPROMPT_BASE"
	fi
}
add-zsh-hook precmd -report-start-time
