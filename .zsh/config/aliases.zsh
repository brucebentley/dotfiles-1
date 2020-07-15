#!/usr/bin/env zsh

alias ......='cd ../../..'
alias ....='cd ../..'
alias ..='cd ..'
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias e=exit
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias g=git
alias groot='cd $(git rev-parse --show-toplevel 2> /dev/null || echo -n ".")'
alias grep='grep -Hn --color'
alias j=jump
alias l='ls -lFh'
alias ll='ls -lAFh'
alias ls='ls --color'
alias n=ncmpcpp
alias r=vifm
alias s=ssh
alias t=tmux
alias v=vi

if command -v nvim > /dev/null; then
	alias vi=nvim
elif command -v vim > /dev/null; then
	alias vi=vim
fi

alias xinit="xinit -- $(tty | sed 's/\/dev\/tty/vt/')"
