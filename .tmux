#!/bin/sh

set -e

if tmux has-session -t=dots 2> /dev/null; then
  tmux attach -t dots
  exit
fi

tmux new-session -d -s dots -n vim -x $(tput cols) -y $(tput lines)

tmux split-window -t dots:vim -h

tmux send-keys -t dots:vim.right "git st" Enter
tmux send-keys -t dots:vim.left "vim -c CommandTBoot" Enter

tmux attach -t dots:vim.right
