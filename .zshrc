#
# Global
#
# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __EMANON

__EMANON[ITALIC_ON]=$'\e[3m'
__EMANON[ITALIC_OFF]=$'\e[23m'
__EMANON[LINE_CURSOR]=$'\e[6 q'
__EMANON[BLOCK_CURSOR]=$'\e[2 q'

#
# Completion
#

fpath=($HOME/.zsh/completions $fpath)

# https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.md-1) ]]; then
        compinit -C
else
        compinit -u
fi

# Make completion:
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# Allow completion of ..<Tab> to ../ and beyond.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

# $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
# to dominate completion; exclude path-directories from the tag-order so that
# they will only be used as a fallback if no completions are found.
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__EMANON[ITALIC_ON]%}--- %d ---%{$__EMANON[ITALIC_OFF]%}%b%f

# Highlight selection
zstyle ':completion:*' menu select

#
# Correction
#

# exceptions to auto-correction
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'

#
# Prompt
#

autoload -U colors
colors

# speed up load time
DISABLE_UPDATE_PROMPT=true

# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green}●%f" # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{red}●%f" # default 'U'
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] ' # default ' (%s)-[%b]%c%u-'
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'

function +vi-git-untracked() {
        emulate -L zsh
        if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
                hook_com[unstaged]+="%F{blue}●%f"
        fi
}

RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f"
setopt PROMPT_SUBST

# Anonymous function to avoid leaking variables.
function () {
        # Check for tmux by looking at $TERM, because $TMUX won't be propagated to any
        # nested sudo shells but $TERM will.
        local TMUXING=$([[ $TERM =~ tmux ]] && echo tmux)
        if [ -n "$TMUXING" -a -n "$TMUX" ]; then
                # In a a tmux session created in a non-root or root shell.
                local LVL=$(($SHLVL-1))
        else
                # Either in a root shell created inside a non-root tmux session,
                # or not in a tmux session.
                local LVL=$SHLVL
        fi
        if [[ $EUID -eq 0 ]]; then
                local SUFFIX='%F{yellow}%n%f'$(printf '%%F{yellow}\u276f%.0s%%f' {1..$LVL})
        else
                local SUFFIX=$(printf '%%F{red}\u276f%.0s%%f' {1..$LVL})
        fi
                PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%B%1~%b%F{yellow}%B%(1j.*.)%(?..!)%b%f %B${SUFFIX}%b "
        if [[ -n $TMUXING ]]; then
                # Outside tmux, ZLE_RPROMPT_INDENT ends up eating the space after PS1, and
                # prompt still gets corrupted even if we add an extra space to compensate.
                ZLE_RPROMPT_INDENT=0
        fi
}

RPROMPT=$RPROMPT_BASE
SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

#
# History
#

HISTSIZE=1000000
HISTFILE="$HOME/.history"
SAVEHIST=$HISTSIZE

#
# Options
#

setopt AUTO_CD                 # [default] .. is shortcut for cd .. (etc)
setopt AUTO_PARAM_SLASH        # tab completing directory appends a slash
setopt AUTO_PUSHD              # [default] cd automatically pushes old dir onto dir stack
setopt AUTO_RESUME             # allow simple commands to resume backgrounded jobs
setopt CLOBBER                 # allow clobbering with >, no need to use >!
setopt CORRECT                 # [default] command auto-correction
setopt CORRECT_ALL             # [default] argument auto-correction
setopt NO_FLOW_CONTROL         # disable start (C-s) and stop (C-q) characters
setopt NO_HIST_IGNORE_ALL_DUPS # don't filter duplicates from history
setopt NO_HIST_IGNORE_DUPS     # don't filter contiguous duplicates from history
setopt HIST_FIND_NO_DUPS       # don't show dupes when searching
setopt HIST_IGNORE_SPACE       # [default] don't record commands starting with a space
setopt HIST_VERIFY             # confirm history expansion (!$, !!, !foo)
setopt IGNORE_EOF              # [default] prevent accidental C-d from exiting shell
setopt INTERACTIVE_COMMENTS    # [default] allow comments, even in interactive shells
setopt LIST_PACKED             # make completion lists more densely packed
setopt MENU_COMPLETE           # auto-insert first possible ambiguous completion
setopt NO_NOMATCH              # [default] unmatched patterns are left unchanged
setopt PRINT_EXIT_VALUE        # [default] for non-zero exit status
setopt PUSHD_IGNORE_DUPS       # don't push multiple copies of same dir onto stack
setopt PUSHD_SILENT            # [default] don't print dir stack after pushing/popping
setopt SHARE_HISTORY           # share history across shells

#
# Bindings
#

bindkey -v # set to -e for emacs bindings, set to -v for vi bindings

# Make vi-mode transition faster
KEYTIMEOUT=1

# Use "cbt" capability ("back_tab", as per `man terminfo`), if we have it:
if tput cbt &> /dev/null; then
        bindkey "$(tput cbt)" reverse-menu-complete # make Shift-tab go to previous completion
fi

# Cursor shape changes in different modes
function zle-keymap-select zle-line-init
{
        if [[ $TERM != linux ]]; then
                if [[ $KEYMAP == main ]]; then
                        printf $__EMANON[LINE_CURSOR]
                else
                        printf $__EMANON[BLOCK_CURSOR]
                fi
        fi
}

zle -N zle-line-init
zle -N zle-keymap-select

# Make CTRL-Z background things and unbackground them.
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

#
# Hooks
#

autoload -U add-zsh-hook

function -set-tab-and-window-title() {
        emulate -L zsh
        local CMD="${1:gs/$/\\$}"
        print -Pn "\e]0;$CMD:q\a"
}

# $HISTCMD (the current history event number) is shared across all shells
# (due to SHARE_HISTORY). Maintain this local variable to count the number of
# commands run in this specific shell.
HISTCMD_LOCAL=0

# Executed before displaying prompt.
function -update-window-title-precmd() {
        emulate -L zsh
        if [[ HISTCMD_LOCAL -eq 0 ]]; then
                # About to display prompt for the first time; nothing interesting to show in
                # the history. Show $PWD.
                -set-tab-and-window-title "$(basename $PWD)"
        else
                local LAST=$(history | tail -1 | awk '{print $2}')
                if [[ -n $TMUX ]]; then
                        # Inside tmux, just show the last command: tmux will prefix it with the
                        # session name (for context).
                        -set-tab-and-window-title "$LAST"
                else
                        # Outside tmux, show $PWD (for context) followed by the last command.
                        -set-tab-and-window-title "$(basename $PWD) > $LAST"
                fi
        fi
}
add-zsh-hook precmd -update-window-title-precmd

# Executed before executing a command: $2 is one-line (truncated) version of
# the command.
function -update-window-title-preexec() {
        emulate -L zsh
        setopt EXTENDED_GLOB
        HISTCMD_LOCAL=$((++HISTCMD_LOCAL))

        # Skip ENV=settings, sudo, ssh; show first distinctive word of command;
        # mostly stolen from:
        #   https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh
        local TRIMMED="${2[(wr)^(*=*|mosh|ssh|sudo)]}"
        if [[ -n $TMUX ]]; then
                # Inside tmux, show the running command: tmux will prefix it with the
                # session name (for context).
                -set-tab-and-window-title "$TRIMMED"
        else
                # Outside tmux, show $PWD (for context) followed by the running command.
                -set-tab-and-window-title "$(basename $PWD) > $TRIMMED"
        fi
}
add-zsh-hook preexec -update-window-title-preexec

typeset -F SECONDS
function -record-start-time() {
        emulate -L zsh
        ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}
add-zsh-hook preexec -record-start-time

function -report-start-time() {
        emulate -L zsh
        if [ $ZSH_START_TIME ]; then
                local DELTA=$(($SECONDS - $ZSH_START_TIME))
                local DAYS=$((~~($DELTA / 86400)))
                local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
                local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
                local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
                local ELAPSED=''
                test "$DAYS" != '0' && ELAPSED="${DAYS}d"
                test "$HOURS" != '0' && ELAPSED="${ELAPSED}${HOURS}h"
                test "$MINUTES" != '0' && ELAPSED="${ELAPSED}${MINUTES}m"
                if [ "$ELAPSED" = '' ]; then
                        SECS="$(print -f "%.2f" $SECS)s"
                elif [ "$DAYS" != '0' ]; then
                        SECS=''
                else
                        SECS="$((~~$SECS))s"
                fi
                ELAPSED="${ELAPSED}${SECS}"
                RPROMPT="%F{cyan}%{$__EMANON[ITALIC_ON]%}${ELAPSED}%{$__EMANON[ITALIC_OFF]%}%f $RPROMPT_BASE"
                unset ZSH_START_TIME
        else
                RPROMPT="$RPROMPT_BASE"
        fi
}
add-zsh-hook precmd -report-start-time

function -auto-ls-after-cd() {
        emulate -L zsh
        # Only in response to a user-initiated `cd`, not indirectly (eg. via another
        # function).
        if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
                ls -a --color=auto
        fi
}
add-zsh-hook chpwd -auto-ls-after-cd

# Remember each command we run.
function -record-command() {
        __EMANON[LAST_COMMAND]="$2"
}
add-zsh-hook preexec -record-command

# Update vcs_info (slow) after any command that probably changed it.
function -maybe-show-vcs-info() {
        local LAST="$__EMANON[LAST_COMMAND]"

        # In case user just hit enter, overwrite LAST_COMMAND, because preexec
        # won't run and it will otherwise linger.
        __EMANON[LAST_COMMAND]="<unset>"
        if [[ $LAST[(w)1] =~ "cd|cp|rm|mv|touch|git" ]]; then
                vcs_info
        fi
}
add-zsh-hook precmd -maybe-show-vcs-info

# adds `cdr` command for navigating to recent directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# enable menu-style completion for cdr
zstyle ':completion:*:*:cdr:*:*' menu selection

# fall through to cd if cdr is passed a non-recent dir as an argument
zstyle ':chpwd:*' recent-dirs-default true

#
# Other
#

source $HOME/.zsh/config/aliases.zsh
source $HOME/.zsh/config/common.zsh
source $HOME/.zsh/config/colors.zsh
source $HOME/.zsh/config/exports.zsh
source $HOME/.zsh/config/functions.zsh
source $HOME/.zsh/config/hash.zsh
source $HOME/.zsh/config/path.zsh
source $HOME/.zsh/config/vars.zsh


#
# Third-party
#

# FZF
export PATH="$PATH:$HOME/.zsh/vendor/fzf/bin"

#
# Plug-ins
#

source $HOME/.zsh/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

source $HOME/.zsh/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#
# /etc/motd
#

if [ -e /etc/motd ]; then
        if ! cmp -s $HOME/.hushlogin /etc/motd; then
                tee $HOME/.hushlogin < /etc/motd
        fi
fi
