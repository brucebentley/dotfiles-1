alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias a=ag
alias bt=btcli
alias cp='cp -rfv'
alias d='hash -d'
alias e=exit
alias f='find . -name'
alias g=git
alias j=jump
alias l='ls --color=auto'
alias ll='ls -alF --color=auto'
alias mkdir='mkdir -pv'
alias n=ncmpcpp
alias r=vifm
alias rm='rm -rfv'
alias s=ssh
alias t=tmux
alias v=vim

if command -v nvim > /dev/null; then
        alias vim=nvim
fi

if command -v htop > /dev/null; then
        alias top=htop
fi
