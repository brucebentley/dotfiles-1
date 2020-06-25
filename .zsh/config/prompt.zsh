#!/usr/bin/env zsh

DISABLE_UPDATE_PROMPT=true

autoload -Uz vcs_info add-zsh-hook

async_start_worker _vcs_info
async_register_callback _vcs_info _vcs_info_callback

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green}●%f"
zstyle ':vcs_info:*' unstagedstr "%F{red}●%f"
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] '
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] '

function +vi-git-untracked() {
	emulate -L zsh

	if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
		hook_com[unstaged]+="%F{blue}●%f"
	fi
}

function _vcs_info_callback() {
	vcs_info
	zle reset-prompt
}

RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f"
SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

setopt PROMPT_SUBST

function () {
	local TMUXING=$([[ $TERM =~ tmux ]] && echo tmux)
	if [ -n "$TMUXING" -a -n "$TMUX" ]; then
		local LVL=$(($SHLVL-1))
	else
		local LVL=$SHLVL
	fi
	if [[ $EUID -eq 0 ]]; then
		local SUFFIX='%F{yellow}%n%f'$(printf '%%F{yellow}\u276f%.0s%%f' {1..$LVL})
	else
		local SUFFIX=$(printf '%%F{red}\u276f%.0s%%f' {1..$LVL})
	fi
	PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%B%1~%b%F{yellow}%B%(1j.*.)%(?..!)%b%f %B${SUFFIX}%b "
	if [[ -n $TMUXING ]]; then
		ZLE_RPROMPT_INDENT=0
	fi
}

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

typeset -F SECONDS
function -record-start-time() {
	emulate -L zsh

	ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}

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
		RPROMPT="%F{cyan}%{$__USER[ITALIC_ON]%}${ELAPSED}%{$__USER[ITALIC_OFF]%}%f $RPROMPT_BASE"
		unset ZSH_START_TIME
	else
		RPROMPT="$RPROMPT_BASE"
	fi
}

add-zsh-hook preexec () {
	-record-start-time
	-update-window-title-preexec
}

add-zsh-hook precmd () {
	async_job _vcs_info vcs_info
	-report-start-time
	-update-window-title-precmd
}
