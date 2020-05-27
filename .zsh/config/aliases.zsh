alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias cp='cp -rfv'
alias d='hash -d'
alias e=exit
alias g=git
alias l='ls --color=auto'
alias ll='ls -alF --color=auto'
alias mkdir='mkdir -pv'
alias mv='mv -fuv'
alias n=ncmpcpp
alias r=vifm
alias rm='rm -rfv'
alias s=ssh
alias t=tmux
alias v=vim

if command -v nvim > /dev/null; then
	alias vim=nvim
fi
