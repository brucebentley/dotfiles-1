function ag() {
        emulate -L zsh

        # italic blue paths, pink line numbers, underlined purple matches
        command ag --pager="less -iFMRSX" --color-path=34\;3 --color-line-number=35 --color-match=35\;1\;4 "$@"
}

function vifm() {
        emulate -L zsh

        if [[ ! -x $(command -v ueberzug) ]]; then
                command vifm
                exit
        else
                export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"
                rm "$FIFO_UEBERZUG" 2> /dev/null
                mkfifo "$FIFO_UEBERZUG"
                trap "rm "$FIFO_UEBERZUG" 2> /dev/null pkill -P $$ 2> /dev/null" EXIT
                tail -f "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash &

                command vifm "$@"
                rm "$FIFO_UEBERZUG" 2> /dev/null
                pkill -P $$ 2> /dev/null
                unset FIFO_UEBERZUG
        fi
}

# fd - "find directory"
# Inspired by: https://github.com/junegunn/fzf/wiki/examples#changing-directory
function fd() {
        local DIR
        DIR=$(find -type d 2> /dev/null | sk --color=16 --no-multi --preview='test -n "{}" && ls {}' -q "$*") && cd "$DIR"
}

# fh - "find [in] history"
# Inspired by: https://github.com/junegunn/fzf/wiki/examples#command-history
function fh() {
        print -z $(fc -l 1 | sk --color=16 --no-multi --tac -q "$*" | sed 's/ *[0-9]*\*\{0,1\} *//')
}

function scratch() {
        local SCRATCH=$(mktemp -d)
        echo 'Spawing subshell in scratch directory:'
        echo "  $SCRATCH"
        (cd $SCRATCH; zsh)
        echo "Removing scratch directory"
        rm -r "$SCRATCH"
}

function ssh() {
        emulate -L zsh

        if [[ -z "$@" ]]; then
                # common case: getting to my workstation
                command ssh dev
        else
                local LOCAL_TERM=$(echo -n "$TERM" | sed -e s/tmux/screen/)
                command env TERM=$LOCAL_TERM ssh "$@"
        fi
}

function tmux() {
        emulate -L zsh

        # Make sure even pre-existing tmux sessions use the latest SSH_AUTH_SOCK.
        # (Inspired by: https://gist.github.com/lann/6771001)
        local SOCK_SYMLINK=~/.ssh/ssh_auth_sock
        if [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ]; then
                ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
        fi

        # If provided with args, pass them through.
        if [[ -n "$@" ]]; then
                env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"
                return
        fi

        # Check for .tmux file (poor man's Tmuxinator).
        if [ -x .tmux ]; then
                # Prompt the first time we see a given .tmux file before running it.
                local DIGEST="$(openssl sha -sha512 .tmux)"
                if ! command ag --silent "$DIGEST" ~/..tmux.digests 2> /dev/null; then
                        cat .tmux
                        read -k 1 -r 'REPLY?Trust (and run) this .tmux file? (t = trust, otherwise = skip) '
                        echo
                        if [[ $REPLY =~ ^[Tt]$ ]]; then
                                echo "$DIGEST" >> ~/..tmux.digests
                                ./.tmux
                                return
                        fi
                else
                        ./.tmux
                        return
                fi
        fi

        # Attach to existing session, or create one, based on current directory.
        local SESSION_NAME=$(basename "${$(pwd)//[.:]/_}")
        env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
}

# regmv = regex + mv (mv with regex parameter specification)
#   example: regmv '/\.tif$/.tiff/' *
#   replaces .tif with .tiff for all files in current dir
#   must quote the regex otherwise "\." becomes "."
# limitations: ? doesn't seem to work in the regex, nor *
function regmv() {
        emulate -L zsh

        if [ $# -lt 2 ]; then
                echo "  Usage: regmv 'regex' file(s)"
                echo "  Where:       'regex' should be of the format '/find/replace/'"
                echo "Example: regmv '/\.tif\$/.tiff/' *"
                echo "   Note: Must quote/escape the regex otherwise \"\.\" becomes \".\""
                return 1
        fi
        local REGEX="$1"
        shift
        while [ -n "$1" ]
        do
                local NEWNAME=$(echo "$1" | sed "s${REGEX}g")
                if [ "${NEWNAME}" != "$1" ]; then
                        mv -i -v "$1" "$NEWNAME"
                fi
                shift
        done
}

# Convenience function for jumping to hashed directory aliases
# (ie. `j rn` -> `jump rn` -> `cd ~rn`).
function jump() {
        emulate -L zsh
        if [ $# -eq 0 ]; then
                fd
        else
                local DIR="${*%%/}"
                if [ $(hash -d|cut -d= -f1 | command ag -c "^${DIR}\$") = 0 ]; then
                        # Not in `hash -d`: use as initial argument to fd.
                        fd "$*"
                else
                        cd ~"$DIR"
                fi
        fi
}

function _jump_complete() {
        emulate -L zsh

        local COMPLETIONS
        COMPLETIONS="$(hash -d|cut -d= -f1)"
        reply=( "${(ps:\n:)COMPLETIONS}" )
}

# Complete filenames and `hash -d` entries.
compctl -f -K _jump_complete jump

# Print a pruned version of a tree.
#
# Examples:
#
#   # Print all "*.js" files in src:
#   subtree '*.js' src
#
#   # Print all "*.js" files in the current directory:
#   subtree '*.js'
#
#   # Print all "*.js" and "*.ts" files in current directory:
#   subtree '*.js|*.ts'
#
function subtree() {
        tree -a --prune -P "$@"
}

# "[t]ime[w]arp" by setting GIT_AUTHOR_DATE and GIT_COMMITTER_DATE.
function tw() {
        emulate -L zsh

        local TS=$(ts "$@")
        echo "Spawning subshell with timestamp: $TS"
        env GIT_AUTHOR_DATE="$TS" GIT_COMMITTER_DATE="$TS" zsh
}

# "tick" by incrementing GIT_AUTHOR_DATE and GIT_COMMITTER_DATE.
function tick() {
        emulate -L zsh

        if [ -z "$GIT_AUTHOR_DATE" -o -z "$GIT_COMMITTER_DATE" ]; then
                echo 'Expected $GIT_AUTHOR_DATE and $GIT_COMMITTER_DATE to be set.'
                echo 'Did you forget to timewarp with `tw`?'
        else
                # Fragile assumption: dates are in format produced by `tw`/`ts`.
                local TS=$(expr \
                        $(echo $GIT_AUTHOR_DATE | cut -d ' ' -f 1) \
                        $(parseoffset "$@") \
                )
                local TZ=$(date +%z)
                echo "Bumping timestamp to: $TS $TZ"
                export GIT_AUTHOR_DATE="$TS $TZ"
                export GIT_COMMITTER_DATE="$TS $TZ"
        fi
}
