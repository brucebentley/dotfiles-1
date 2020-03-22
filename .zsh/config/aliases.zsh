#
# Command aliases
#

alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias :sp='test -n "$TMUX" && tmux split-window'
alias :vs='test -n "$TMUX" && tmux split-window -h'
alias a=ag
alias d='hash -d'
alias e=exit
alias f='find . -name'
alias g=git
alias groot='cd $(git rev-parse --show-toplevel 2> /dev/null || echo -n ".")'
alias h=history
alias j=jump
alias l='ls --color'
alias ll='ls -al --color'
alias n=ncmpcpp
alias o='git log --oneline'
alias oo='git log --oneline -10'
alias p='git format-patch'
alias r=ranger
alias s=ssh
alias server='python -m littlehttpserver' # optional arg: port (defaults to 8000)
alias t=tmux
alias v=vim

# IP related
alias publicip="curl -fSs https://1.1.1.1/cdn-cgi/trace | awk -F= '/ip/ { print $2 }'"
alias privateip="ip addr | ag 'inet ' | awk -F'[: ]+' '{ if (\$4 ~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) { print \$4 } else { print \$3 }}'"

# Type vim to use neovim
if command -v nvim &> /dev/null; then
        alias vim=nvim # Use `\vim` or `command vim` to get the real vim.
fi
