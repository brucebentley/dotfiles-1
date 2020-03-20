# Execute code inn the background to not affect the current session
(
    # <https://github.com/zimfw/zimfw/blob/master/login_init.zsh>
    setopt LOCAL_OPTIONS EXTENDED_GLOB

    # Compile zcompdump, if modified, to increase startup speed.
    local zcompdump="$HOME/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile -M "$zcompdump"
    fi
    # zcompile .zshrc
    zcompile -M $HOME/.zshrc
    zcompile -M $HOME/.zprofile
    zcompile -M $HOME/.zshenv
    # recompile all zsh or sh
    for f in $HOME/.zsh/config/**/*.*sh
    do
        zcompile $f
    done
) &!

#eval "$(rbenv init -)"
