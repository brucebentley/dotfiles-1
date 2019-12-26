#!/usr/bin/env bash

# SIMPLE BASH SCRIPT (TOO LAZY TO USE ANSIBLE
# HOME DIRECTORY
ln -sf $PWD/.z* $HOME
ln -sfr $PWD/.zsh $HOME
ln -sf $PWD/.tmux.conf $HOME
ln -sf $PWD/.xinitrc $HOME
ln -sfr $PWD/.vim $HOME
ln -sfr $PWD/.fonts $HOME
# ~/.config
ln -sfr $PWD/.config/* $HOME/.config/
ln -sfr $PWD/.vim $HOME/.config/nvim
