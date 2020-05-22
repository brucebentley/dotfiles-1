export CORRECT_IGNORE_FILE='.*'

export PAGER=less
export LESS='-iFMRSX'

if command -v nvim > /dev/null; then
        export EDITOR=nvim
        export MANPAGER='nvim +Man!'
else
        export EDITOR=vim
fi

