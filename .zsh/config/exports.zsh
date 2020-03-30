# Stop (eg.) `git push github` from triggering:
# zsh: correct 'github' to '.github' [yes, no, edit, abort]?
export CORRECT_IGNORE_FILE='.*'

export PAGER=less

if which nvim &> /dev/null; then
        export EDITOR=$(which nvim)
elif [ -x "$HOME/bin/vim" ]; then
        # PATH isn't set yet (.zsh/path depends on this file), so we do this check
        # instead of a simple `export EDITOR=$(which vim)`:
        export EDITOR=$HOME/bin/vim
else
        export EDITOR=vim
fi

if [ -d /usr/local/opt/mysql@5.7 ]; then
        # Uncomment if you need to build anything that links against this version:
        # export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
        # export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
        # export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"
fi

# usually this means running on a machine with a statically-linked, hand-built
# tmux (and ncurses)
if [ -d "$HOME/share/terminfo" ]; then
        export TERMINFO=$HOME/share/terminfo
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

# for the benefit of CPAN and potentially others
export FTP_PASSIVE=1

# colour ls listings
export CLICOLOR=1
