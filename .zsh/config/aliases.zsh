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
alias grep='grep -Hn --color=always'
alias j=jump
alias l='ls -lFh'
alias ll='ls -lAFh'
alias ls='ls --color=always'
alias n=ncmpcpp
alias r=vifm
alias s=ssh
alias t=tmux
alias v=vi

if command -v nvim > /dev/null; then
	alias vi=nvim
fi

alias cp='nocorrect cp'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
