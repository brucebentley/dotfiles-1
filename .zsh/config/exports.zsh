if [[ -x $(command -v less) ]]; then
        export PAGER=less
fi

if [[ -x $(command -v nvim) ]]; then
        export EDITOR=nvim
        export MANPAGER='nvim +Man!'
else
        export EDITOR=vim
        export MANPAGER='vim +Man!'
fi
