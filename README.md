# Dependencies
- [git](https://github.com/git/git) => 1.8.2
- [neovim](https://github.com/neovim/neovim) => 0.5.0
- [tmux](https://github.com/tmux/tmux) => 2.8
- [vifm](https://github.com/vifm/vifm) => 0.8
  - [ueberzug](https://github.com/seebye/ueberzug)(optional) - for image preview
  - [fontpreview](https://github.com/sdushantha/fontpreview)(optional) - for font preview
- [zsh](https://github.com/zsh-users/zsh) => 5.6

# Installation

## Clone

``` sh
git clone --recursive https://github.com/Z5483/dotfiles
```

## Install

``` sh
./install
```

**Note:** Given that `~/.gitconfig` is included with these dotfiles, any local configurations should be written to `~/.gitconfig.local` instead such as:

```sh
git config --file ~/.gitconfig.local user.name  "John Doe"
git config --file ~/.gitconfig.local user.email "johndoe@example.com"
```
