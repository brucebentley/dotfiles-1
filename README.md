# SCREENSHOT
<img src="screenshot/0001">
<img src="screenshot/0002">

# SYSTEM CONFIGURATION

* `distro`: gentoo
* `wm`: dwm
* `terminal`: st
* `shell`: zsh
* `browser`: surf
* `editor`: neovim
* `music player`: ncmpcpp/spotify
* `font`: Deja Vu Sans Mono

# ZSH

## SHELL FUNCTIONS

- `ag`: Transparently wraps the `ag` executable so as to provide a centralized place to set defaults for that command (seeing as it has no "rc" file).
- `color`: change terminal and Vim color scheme.
- `fd`: "find directory" using fast `bfs` and `sk`; automatically `cd`s into the selected directory.
- `fh`: "find [in] history"; selecting a history item inserts it into the command line but does not execute it.
- `history`: overrides the (tiny) default history count.
- `jump` (aliased to `j`): to jump to hashed directories.
- `regmv`: bulk-rename files (eg. `regmv '/\.tif$/.tiff/' *`).
- `scratch`: create a random temporary scratch directory and `cd` into it.
- `tick`: moves an existing time warp (eg. `tick +1h`); see `tw` below for a description of time warp.
- `tmux`: wrapper that reattches to pre-existing sessions, or creates new ones based on the current directory name; additionally, looks for a `.tmux` file to set up windows and panes (note that the first time a given `.tmux` file is encountered the wrapper asks the user whether to trust or skip it).
- `tw` ("time warp"): overrides `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` (eg. `tw -1d`).

## VI MODE

Escape key is mapped to `esc key` and `''`(two single quotes).

Depends on the mode, the cursor will change its shape. In insert mode, the
cursor will be a thin vertical bar. In normal/visual mode, the cursor will be in
a block shape.

**Note:** the cursor shapeshifting function only works on terminal emulators and
not on the console.

## THIRD-PARTY SCRIPT

- `epr`: CLI EPUB files reader (https://github.com/wustho/epr)
- `speedtest`: a CLI script for testing internet bandwidth using Ookla's speedtest.net (https://github.com/sivel/speedtest-cli)
- `setup-tor-iptables`: setup iptables for tor service (https://github.com/jessfraz/dotfiles/blob/master/bin/setup-tor-iptables)
- `update-firmware`: update firmware from the linux firmware repo which ahs the latest builds (https://github.com/jessfraz/dotfiles/blob/master/bin/update-firmware)
- `update-iwlwifi`: update iwlwifi firmware from intel's linux fork (https://github.com/jessfraz/dotfiles/blob/master/bin/update-iwlwifi)
- `bonsai`: a CLI bonsai tree generator (https://gitlab.com/jallbrit/bonsai.sh)
- `pfetch`: a simple system information displayer (https://github.com/dylanaraps/pfetch)
- `neofetch`: a CLI system information tool (https://github.com/dylanaraps/neofetch)

# INSTALL

1. git clone --recursive https://github.com/Z5483/dotfiles
2. ./install

```
./install.sh will install everything on the local system by creating symbolic links to the target location
```

**Note:** The `ln -sf` command will overwrite existing files, but will fail to overwrite existing directories.

**Note:** Given that `~/.gitconfig` is included with these dotfiles, any local configurations should be written to `~/.gitconfig.local` instead such as:

```
git config --file ~/.gitconfig.local user.name "username"
git config --file ~/.gitconfig.local user.email "user@example.com"
```

**Note:** Before opening vim for the first time, you should use the `color` function to set a color first because there's no default color
