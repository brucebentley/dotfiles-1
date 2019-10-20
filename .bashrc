# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#use vim keybinding
set -o vi
#bind <END> key to Ctrl-e and <HOME> to Ctrl-a because bindings in inputrc not working
bind -m vi-command ' "\C-e": end-of-line '
bind -m vi-command ' "\C-a": beginning-of-line '

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
  fi

  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
  fi

#Manage vim swapfile
function vim-process-swap {
  local swapfile_first=0
  while true; do
    case "$1" in
      ""|-h|--help)
        echo "usage: vim-process-swap file [swapfile [recoverfile]]" >&2
        return 1;;
      -s)
        shift
        swapfile_first=1;;
      *)
        break;;
    esac
  done
  local realfile=`readlink -f "$1"`
  local path=`dirname "$realfile"`
  local realname=`basename "$realfile"`
  if [ $swapfile_first -eq 1 ]; then
    local swapfile=$realfile
    realname=${realname:1:-4}
    realfile="${path}/${realname}"
  else
    local swapfile=${2:-"${path}/.${realname}.swp"}
  fi
  local recoverfile=${3:-"${path}/${realname}-recovered"}
  local lastresort=0
  for f in "$realfile" "$swapfile"; do
    if [ ! -f "$f" ]; then
      echo "File $f does not exist." >&2
      return 1
    elif fuser "$f"; then
      echo "File $f in use by process." >&2
      return 1
    fi
  done
  if [ -f "$recoverfile" ]; then
    echo "Recover file $recoverfile already exists. Delete existing recover file first." >&2
    return 1
  fi
  vim -u /dev/null --noplugin -r "$swapfile" -c ":wq $recoverfile"
  if cmp -s "$realfile" "$recoverfile"; then
    rm "$swapfile" "$recoverfile"
  elif [ "$realfile" -nt "$swapfile" ] && [ `stat -c%s "$realfile"` -gt `stat -c%s "$recoverfile"` ]; then
    echo "Swapfile is older than realfile, and recovered file is smaller than realfile"
    if _prompt_yn "Delete recovered file and swapfile without doing diff?"; then
      rm "$swapfile" "$recoverfile"
    else
      lastresort=1
    fi
  else
    lastresort=1
    fi

    if [[ "$lastresort" -ne 0 ]]; then
      rm "$swapfile"
      vimdiff "$recoverfile" "$realfile"
      if _prompt_yn "Delete recovered file?"; then
        rm "$recoverfile"
      fi
      fi

    }

  function _prompt_yn {
    while true; do
      read -p "$1 [y|n] " yn
      case $yn in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) echo "Please answer yes or no.";;
      esac
    done
  }

#cd into last directory
cl() {
  last_dir="$(ls -Frt | grep '/$' | tail -n1)"
  if [ -d "$last_dir" ]; then
    cd "$last_dir"
  fi
}

#cd into a directory then ls
cdls () { cd "$1"; ls; }

#bookmarking directory
rd() {
  pwd > "$HOME/.lastdir_$1"
}
crd() {
  lastdir="$(cat "$HOME/.lastdir_$1")">>/dev/null 2>&1
  if [ -d "$lastdir" ]; then
    cd "$lastdir"
  else 
    echo "no existing directory stored in buffer $1">&2
  fi
}


#Base16 shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

#Custom path
export PATH=$PATH:/home/emanon/bin/
export PATH=$PATH:/home/emanon/bin/python/
export PATH=$PATH:/home/emanon/bin/shell/


#Color for man page
man() {
  LESS_TERMCAP_mb=$'\e[1;32m' \
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
  }

#alias
alias e="exit"
alias reset="reset && monokai"
alias ll="ls -l -B -G"
alias la="ls -al -B -G"
alias lh="ls -lh -B -G"
alias l="ls -B -c -G"
alias t="tmux attach"
alias tk="tmux kill-server"
alias v="vim"
alias diskspace="du -S | sort -n -r | less"
alias port="ss -aut"
alias genpasswd="strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 40 |
tr -d '\n' ; echo"
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"
alias bashrc="vim .bashrc"
alias vimrc="vim .vim/vimrc"
alias tmux.conf="vim .tmux.conf"
alias inputrc="vim .inputrc"
alias monokai="base16_monokai"
alias ocean="base16_ocean"
alias snazzy="base16_snazzy"
alias atelier-dune-light="base16_atelier-dune-light"
alias twilight="base16_twilight"
alias grayscale-dark="base16_grayscale-dark"
