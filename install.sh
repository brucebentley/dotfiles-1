#!/bin/sh

# SIMPLE BASH INSTALLATION SCRIPT (TOO LAZY TO SETUP ANSIBLE)

# HOME DIRECTORY
ln -sf $PWD/.asoundrc  $HOME
ln -sf $PWD/.fonts     $HOME
ln -sf $PWD/.inputrc   $HOME
ln -sf $PWD/.lynxrc    $HOME
ln -sf $PWD/.mpd       $HOME
ln -sf $PWD/.ncmpcpp   $HOME
ln -sf $PWD/.tmux.conf $HOME
ln -sf $PWD/.xinitrc   $HOME
ln -sf $PWD/.z*        $HOME
ln -sf $PWD/.zsh       $HOME

# ~/.config
if [ ! -d $HOME/.config ]; then
        mkdir $HOME/.config
fi

ln -sf $PWD/.config/* $HOME/.config/

# create symlink to .vim if target path doesn't exist
if [ ! -d $HOME/.config/nvim ]; then
        ln -sf $PWD/.vim $HOME/.config/nvim
elif [ ! -d $HOME/.vim ]; then
        ln -sf $PWD/.vim $HOME
fi

# Setup Command-T
if [ ! -f $HOME/.vim/pack/bundle/opt/Command-T/ruby/command-t/ext/command-t/ext.so ]; then
        cd $HOME/.vim/pack/bundle/opt/Command-T/ruby/command-t/ext/command-t/
        ruby extconf.rb
        make
fi

# Install skim
if [ ! -f $HOME/.zsh/vendor/skim/bin/sk ]; then
        cd $HOME/.zsh/vendor/skim
        bash install
fi
