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

alias publicip="curl -fSs https://1.1.1.1/cdn-cgi/trace | awk -F= '/ip/ { print $2 }'"
alias privateip="ip addr | ag 'inet ' | awk -F'[: ]+' '{ if (\$4 ~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) { print \$4 } else { print \$3 }}'"

if command -v nvim > /dev/null; then
        alias vim=nvim
fi

if command -v htop > /dev/null; then
        alias top=htop
fi
