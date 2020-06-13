fpath=($HOME/.zsh/completions $fpath)

if [[ -n $HOME/.zcompdump(#qN.md-1) ]]; then
	compinit -C
else
	compinit -i -u
fi

zstyle ':completion:*' menu select

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__EMANON[ITALIC_ON]%}--- %d ---%{$__EMANON[ITALIC_OFF]%}%b%f
