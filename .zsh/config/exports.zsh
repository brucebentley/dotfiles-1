# Stop (eg.) `killall vim`` from triggering:
# zsh: correct 'vim' to '.vim' [yes, no, edit, abort]?
export CORRECT_IGNORE_FILE='.*'

export PAGER=less
export LESS='-iFMRSX'

if [[ -x $(command -v nvim) ]]; then
        export EDITOR=nvim
        export MANPAGER='nvim +Man!'
else
        export EDITOR=vim
        export MANPAGER='vim +Man!'
fi

