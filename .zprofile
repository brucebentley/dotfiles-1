export LC_ALL="en_US.UTF8"
export LANG="en_US.UTF8"

SYSTEM_PATH="$PATH"
unset PATH
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/bin"

if [ -d /usr/lib/llvm/10/bin ]; then
	PATH="$PATH:/usr/lib/llvm/10/bin"
fi

PATH="$PATH:/bin"
PATH="$PATH:/sbin"

PATH="$PATH:/usr/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/sbin"
export PATH

if command -v less > /dev/null; then
	export MANPAGER=less
	export PAGER=less
elif command -v more > /dev/null; then
	export MANPAGER=more
	export PAGER=more
fi


if command -v nvim > /dev/null; then
	export EDITOR=nvim
elif command -v vim > /dev/null; then
	export EDITOR=vim
else
	export EDITOR=vi
fi

(
	zcompare() {
		if [ -s "$1" ] && [ ! -s "$1".zwc ] || \
		   [ -n "$( find -L "$1" -prune -newer "$1".zwc)" ]; then
			zcompile -M "$1"
		fi
	}

	zcompare "$HOME/.zcompdump"
	zcompare "$HOME/.zprofile"
	zcompare "$HOME/.zshenv"
	zcompare "$HOME/.zshrc"

	for file in "$HOME"/.zsh/**/*.{sh,zsh}; do
		zcompare "$file" 2> /dev/null
	done

	unfunction zcompare
) > /dev/null &!
