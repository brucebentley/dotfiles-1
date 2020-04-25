# Stop (eg.) `git push github` from triggering:
# zsh: correct 'github' to '.github' [yes, no, edit, abort]?
export CORRECT_IGNORE_FILE='.*'

export PAGER=less

if [[ -x $(which nvim) ]]; then
        export EDITOR=nvim
        export MANPAGER='nvim +Man!'
else
        export EDITOR=vim
        export MANPAGER='vim +Man!'
fi

# usually this means running on a machine with a statically-linked, hand-built
# tmux (and ncurses)
if [ -d "$HOME/share/terminfo" ]; then
        export TERMINFO=$HOME/.terminfo
fi

# filename (if known), line number if known, falling back to percent if known,
# falling back to byte offset, falling back to dash
export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

# i = case-insensitive searches, unless uppercase characters in search string
# F = exit immediately if output fits on one screen
# M = verbose prompt
# R = ANSI color support
# S = chop long lines (rather than wrap them onto next line)
# X = suppress alternate screen
export LESS=iFMRSX

# Color man pages.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;208m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;111m'
