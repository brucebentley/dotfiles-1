typeset -A __EMANON

__EMANON[ITALIC_ON]=$'\033[3m'
__EMANON[ITALIC_OFF]=$'\033[23m'
__EMANON[LINE_CURSOR]=$'\033[6 q'
__EMANON[BLOCK_CURSOR]=$'\033[2 q'

fpath=($HOME/.zsh/completions $fpath)

autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.md-1) ]]; then
	compinit -C
else
	compinit -i -u
fi

zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors ''

zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__EMANON[ITALIC_ON]%}--- %d ---%{$__EMANON[ITALIC_OFF]%}%b%f

zstyle ':completion:*' menu select

autoload -U colors
colors

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*:*:cdr:*:*' menu selection

zstyle ':chpwd:*' recent-dirs-default true

autoload -Uz vcs_info
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

DISABLE_UPDATE_PROMPT=true

RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f"
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

RPROMPT=$RPROMPT_BASE
SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

HISTSIZE=1000000
HISTFILE="$HOME/.history"
SAVEHIST=$HISTSIZE

setopt AUTO_CD
setopt CORRECT
setopt CORRECT_ALL
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt LIST_PACKED
setopt MENU_COMPLETE
setopt SHARE_HISTORY

bindkey -v

KEYTIMEOUT=1

if tput cbt &> /dev/null; then
	bindkey "$(tput cbt)" reverse-menu-complete
fi

function zle-keymap-select zle-line-init
{
	if [[ $TERM != linux ]]; then
		if [[ $KEYMAP == main ]]; then
			printf $__EMANON[LINE_CURSOR]
		else
			printf $__EMANON[BLOCK_CURSOR]
		fi
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

autoload -U add-zsh-hook

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

function -auto-ls-after-cd() {
	emulate -L zsh
	if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
		ls -a --color=auto
	fi
}
add-zsh-hook chpwd -auto-ls-after-cd

function -record-command() {
	__EMANON[LAST_COMMAND]="$2"
}
add-zsh-hook preexec -record-command

function -maybe-show-vcs-info() {
	local LAST="$__EMANON[LAST_COMMAND]"

	__EMANON[LAST_COMMAND]="<unset>"
	if [[ $LAST[(w)1] =~ "cd|cp|rm|mv|touch|git" ]]; then
		vcs_info
	fi
}
add-zsh-hook precmd -maybe-show-vcs-info

source $HOME/.zsh/config/aliases.zsh
source $HOME/.zsh/config/colors.zsh
source $HOME/.zsh/config/exports.zsh
source $HOME/.zsh/config/functions.zsh
source $HOME/.zsh/config/path.zsh

export PATH="$PATH:$HOME/.zsh/vendor/fzf/bin"

source $HOME/.zsh/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

source $HOME/.zsh/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
