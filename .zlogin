(
zcompare() {
	if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
		zcompile -M ${1}
	fi
}
setopt EXTENDED_GLOB

zcompare $HOME/.zcompdump
zcompare $HOME/.zshrc
zcompare $HOME/.zshenv

for file in $HOME/.zsh/config/**/*.*zsh; do
	zcompare ${file}
done
) &!
