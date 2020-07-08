#!/usr/bin/env zsh

export CORRECT_IGNORE_FILE='.*'

export LC_ALL=en_US.UTF8
export LANG=en_US.UTF8

SYSTEM_PATH=$PATH
unset PATH

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/.zsh/bin
PATH=$PATH:$HOME/bin

if [[ -d /usr/lib/llvm/10/bin ]]; then
	PATH=$PATH:/usr/lib/llvm/10/bin
fi

PATH=$PATH:/bin
PATH=$PATH:/sbin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/sbin
export PATH

if command -v nvim > /dev/null; then
	export EDITOR=nvim
else
	export EDITOR=vi
fi

export MANPAGER=less

export PAGER=less

export LESS='-iFMRSX'

export LESSHISTFILE=/dev/null

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;208m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;111m'
