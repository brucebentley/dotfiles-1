#!/usr/bin/env zsh

autoload -U compinit

fpath+=$HOME/.zsh/completions

if [[ -n $HOME/.zcompdump(#qN.md-1) ]]; then
	compinit -C
else
	compinit -i -u
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__USER[ITALIC_ON]%}--- %d ---%{$__USER[ITALIC_OFF]%}%b%f
