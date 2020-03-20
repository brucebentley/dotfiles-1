# Execute code inn the background to not affect the current session
(
        zcompare() {
                if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
                        zcompile -M ${1}
                fi
        }
        # <https://github.com/zimfw/zimfw/blob/master/login_init.zsh>
        setopt EXTENDED_GLOB

        # recompile zshrc and .zshenv if modified
        zcompare $HOME/.zcompdump
        zcompare $HOME/.zshrc
        zcompare $HOME/.zshenv

        # recompile all zsh or sh if modified
        for file in $HOME/.zsh/config/**/*.*sh; do
                zcompare ${file}
        done
) &!

#eval "$(rbenv init -)"
