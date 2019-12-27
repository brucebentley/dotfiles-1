#!/usr/bin/env bash

# SIMPLE BASH SCRIPT (TOO LAZY TO SETUP ANSIBLE)

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

# Install Language Client
bash $HOME/.vim/pack/bundle/opt/LanguageClient-neovim/install.sh

# Setup Command-T
cd $HOME/.vim/pack/bundle/opt/Command-T/ruby/command-t/ext/command-t/
ruby extconf.rb
make

# Install skim
bash $HOME/.zsh/vendor/skim/install
