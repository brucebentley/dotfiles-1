#!/usr/bin/env zsh

if [[ $TERM = "linux" ]]; then
	sh $HOME/.zsh/bin/motd
fi

(
	zcompare() {
		if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
			zcompile -M ${1}
		fi
	}

	zcompare $HOME/.zcompdump
	zcompare $HOME/.zlogin
	zcompare $HOME/.zprofile
	zcompare $HOME/.zshenv
	zcompare $HOME/.zshrc

	for file in $HOME/.zsh/**/*.{sh,zsh}; do
		zcompare ${file}
	done

	unfunction zcompare
) &!
