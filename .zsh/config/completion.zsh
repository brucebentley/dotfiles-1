fpath=($HOME/.zsh/completions $fpath)

autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.md-1) ]]; then
	compinit -C
else
	compinit -i -u
fi

zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format %F{default}%B%{$__EMANON[ITALIC_ON]%}--- %d ---%{$__EMANON[ITALIC_OFF]%}%b%f
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'
