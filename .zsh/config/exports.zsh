export PAGER=less
export LESS='-iFMRSX'

if [[ -x $(command -v nvim) ]]; then
        export EDITOR=nvim
        export MANPAGER='nvim +Man!'
else
        export EDITOR=vim
        export MANPAGER='vim +Man!'
fi

