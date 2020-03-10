#!/bin/sh

# SIMPLE BASH INSTALLATION SCRIPT (TOO LAZY TO SETUP ANSIBLE)

# HOME DIRECTORY
ln -sf $PWD/.asoundrc $HOME
ln -sfr $PWD/.fonts $HOME
ln -sfr $PWD/.mpd $HOME
ln -sfr $PWD/.ncmpcpp $HOME
ln -sf $PWD/.tmux.conf $HOME
ln -sfr $PWD/.vim $HOME
ln -sf $PWD/.xinitrc $HOME
ln -sf $PWD/.z* $HOME
ln -sfr $PWD/.zsh $HOME

# ~/.config
mkdir $HOME/.config

ln -sfr $PWD/.config/* $HOME/.config/

if [ ! -L $HOME/.config/vim ]; then
  ln -sfr $PWD/.vim $HOME/.config/nvim
fi

# Setup Command-T
cd $HOME/.vim/pack/bundle/opt/Command-T/ruby/command-t/ext/command-t/
ruby extconf.rb
make

# Install skim
cd $HOME/.zsh/vendor/skim
bash install
