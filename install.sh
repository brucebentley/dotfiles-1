#!/usr/bin/env bash

# SIMPLE BASH INSTALLATION SCRIPT (TOO LAZY TO SETUP ANSIBLE)

# HOME DIRECTORY
ln -sf $PWD/.asoundrc $HOME
ln -sfr $PWD/.fonts $HOME
ln -sf $PWD/.tmux.conf $HOME
ln -sfr $PWD/.vim $HOME
ln -sf $PWD/.xinitrc $HOME
ln -sf $PWD/.z* $HOME
ln -sfr $PWD/.zsh $HOME

# ~/.config
ln -sfr $PWD/.config/* $HOME/.config/
ln -sfr $PWD/.vim $HOME/.config/nvim

# Setup clipper
mkdir -p $HOME/.config/clipper/logs
touch $HOME/.config/clipper/logs/clipper.log
ln -sf $PWD/.clipper.json $HOME/.config/clipper/clipper.json

# Install Language Client
cd $HOME/.vim/pack/bundle/opt/LanguageClient-neovim
bash install.sh

# Setup Command-T
cd $HOME/.vim/pack/bundle/opt/Command-T/ruby/command-t/ext/command-t/
ruby extconf.rb
make

# Install skim
cd $HOME/.zsh/vendor/skim
bash install
