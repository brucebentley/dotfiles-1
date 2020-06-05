# Dependencies
- [git](https://github.com/git/git) => 1.8.2
- [Neovim](https://github.com/neovim/neovim) => 0.4.3 or [Vim](https://github.com/vim/vim) => 8.0 with Ruby and Python support
- [tmux](https://github.com/tmux/tmux) => 2.8
- [vifm](https://github.com/vifm/vifm) => 0.8
  - [ueberzug](https://github.com/seebye/ueberzug)(optional) - for image preview
  - [fontpreview](https://github.com/sdushantha/fontpreview)(optional) - for font preview
- [the silver searcher](https://github.com/ggreer/the_silver_searcher)
- [zsh](https://github.com/zsh-users/zsh) => 5.6

# Installation

1. git clone --recursive https://github.com/Z5483/dotfiles
2. ./install [options]

```sh
install help      # display all options
install git       # install git config only
install zsh       # install zsh config only
install vim       # install vim config only
install all       # install everything
install fonts     # install font files only
install clean     # remove all created symlink files
install conflict  # list conflicted directories
```

**Note:** The `ln -sf` command will overwrite existing files, but will fail to overwrite existing directories.

**Note:** When `./install clean` is executed, it will remove the existing symlink that has identical name as one of file in this repository.

**Note:** Given that `~/.gitconfig` is included with these dotfiles, any local configurations should be written to `~/.gitconfig.local` instead such as:

```sh
git config --file ~/.gitconfig.local user.name  "John Doe"
git config --file ~/.gitconfig.local user.email "johndoe@example.com"
```
