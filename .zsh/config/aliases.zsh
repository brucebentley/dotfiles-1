#!/usr/bin/env zsh

alias ......='cd ../../..'
alias ....='cd ../..'
alias ..='cd ..'
alias e=exit
alias g=git
alias grep='grep -HRn --color=always'
alias j=jump
alias l='ls --color=always'
alias ll='ls -al --color=always'
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
