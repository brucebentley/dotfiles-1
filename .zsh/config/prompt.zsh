#!/usr/bin/env zsh

typeset -F SECONDS
prompt_record_start_time() {
	ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}

prompt_report_start_time() {
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
		RPROMPT="%F{cyan}%{$USER[ITALIC_ON]%}${ELAPSED}%{$USER[ITALIC_OFF]%}%f $RPROMPT_BASE"
		unset ZSH_START_TIME
	else
		RPROMPT="$RPROMPT_BASE"
	fi
}

prompt_async_vcs_info() {
	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' check-for-changes true
	zstyle ':vcs_info:*' stagedstr "%F{green}●%f"
	zstyle ':vcs_info:*' unstagedstr "%F{red}●%f"
	zstyle ':vcs_info:*' use-simple true
	zstyle ':vcs_info:git+set-message:*' hooks git-untracked
	zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] '
	zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] '

	+vi-git-untracked() {
		if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
			hook_com[unstaged]+="%F{blue}●%f"
		fi
	}

	vcs_info
}

prompt_async_renice() {
	if command -v renice >/dev/null; then
		renice +15 -p $$
	fi

	if command -v ionice >/dev/null; then
		ionice -c 3 -p $$
	fi
}

prompt_async_init() {
	typeset -g prompt_async_init
	if ((${prompt_async_init:-0})); then
		return
	fi
	prompt_async_init=1

	async_start_worker prompt_async -u -n
	async_register_callback prompt_async prompt_async_callback
	async_worker_eval prompt_async prompt_async_renice
}

prompt_async_tasks() {
	prompt_async_init

	async_worker_eval prompt_async builtin cd -q $PWD

	async_job prompt_async prompt_async_vcs_info
}

prompt_async_callback() {
	local job=$1 code=$2

	case $job in
	\[async])
		if (( code == 2 )) || (( code == 3 )) || (( code == 130 )); then
			typeset -g prompt_async_init=0
			async_stop_worker prompt_async
			prompt_async_init
			prompt_async_tasks
		fi
		;;
	\[async/eval])
		if (( code )); then
			prompt_async_tasks
		fi
		;;
	prompt_async_vcs_info)
		prompt_async_vcs_info
		zle && zle reset-prompt
		;;
	esac
}

prompt_setup() {
	setopt PROMPT_SUBST

	DISABLE_UPDATE_PROMPT=true

	autoload -Uz add-zsh-hook
	autoload -Uz vcs_info

	RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f"
	SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

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

	add-zsh-hook precmd prompt_async_tasks
	add-zsh-hook precmd prompt_report_start_time
	add-zsh-hook preexec prompt_record_start_time
}

prompt_setup "$@"
