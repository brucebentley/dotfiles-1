#!/usr/bin/env zsh

alias ......='cd ../../..'
alias ....='cd ../..'
alias ..='cd ..'
alias e=exit
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias g=git
alias grep='grep -HRn --color=always'
alias j=jump
alias l='ls -lFh --color=always'
alias ll='ls -lAFh --color=always'
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
