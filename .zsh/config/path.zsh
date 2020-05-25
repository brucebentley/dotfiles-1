SYSTEM_PATH=$PATH
unset PATH

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.zsh/bin
PATH=$PATH:$HOME/.local/bin

if [[ -d /usr/lib/llvm/10/bin ]]; then
	PATH=$PATH:/usr/lib/llvm/10/bin
fi

PATH=$PATH:/bin
PATH=$PATH:/sbin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
export PATH
