#!/usr/bin/env zsh

autoload -Uz compinit

fpath=($HOME/.zsh/completions $fpath)

if [[ -n $HOME/.zcompdump(#qN.md-1) ]]; then
	compinit -i -u
else
	rm -f $HOME/.zcompdump* && compinit -C
fi

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__USER[ITALIC_ON]%}--- %d ---%{$__USER[ITALIC_OFF]%}%b%f
