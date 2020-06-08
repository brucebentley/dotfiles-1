export CORRECT_IGNORE_FILE='.*'

export FZF_DEFAULT_COMMAND="find -L"
export FZF_DEFAULT_OPTS="--algo=v1 --color=16"

export PAGER=less
export LESS='-iFMRSX'

if command -v nvim > /dev/null; then
	export EDITOR=nvim
	export MANPAGER='nvim +Man!'
else
	export EDITOR=vim
	export MANPAGER='less'
fi
