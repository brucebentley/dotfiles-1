# Execute code inn the background to not affect the current session
(
    # <https://github.com/zimfw/zimfw/blob/master/login_init.zsh>
    setopt LOCAL_OPTIONS EXTENDED_GLOB
    autoload -U zrecompile

    # Compile zcompdump, if modified, to increase startup speed.
    local zcompdump="$HOME/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zrecompile -pq "$zcompdump"
    fi
    # zcompile .zshrc
    zrecompile -pq $HOME/.zshrc
    zrecompile -pq $HOME/.zprofile
    zrecompile -pq $HOME}/.zshenv
    # recompile all zsh or sh
    for f in $HOME/.zsh/config/**/*.*sh
    do
        zrecompile -pq $f
    done
) &!

#eval "$(rbenv init -)"
