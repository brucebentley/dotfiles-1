# SCREENSHOT
![](https://raw.githubusercontent.com/Z5483/dotfiles/master/.img/desktop-tiling)
![](https://raw.githubusercontent.com/Z5483/dotfiles/master/.img/desktop-floating)

# SYSTEM CONFIGURATION

* `distro`: gentoo
* `wm`: dwm
* `terminal`: st
* `shell`: zsh
* `browser`: surf
* `editor`: neovim
* `music player`: ncmpcpp/spotify
* `font`: DejaVu Sans Mono

# ZSH

Heavily inspired by https://github.com/wincent/wincent

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

Escape key is mapped to `esc` and `'' (two single quotes)`.

Depends on the mode, the cursor will change its shape.

| State  | Cursor Shape |
| ------------- | ------------- |
| `Normal`  | `block (█)`  |
| `Insert`  | `vertial bar (\|)` |
| `Visual`  | `block (█)` |

> **Note:** the cursor shapeshifting function only works on terminal emulators and not on the console.

## PROMPT

Zsh is configured with the following prompt:

![](https://raw.githubusercontent.com/wincent/wincent/media/prompt.png)

Visible here are:

- Concise left-hand prompt consisting of:
  - Last component of current directory (abbreviates `$HOME` to `~` if possible).
  - Prompt marker, `❯`, the "[HEAVY RIGHT-POINTING ANGLE QUOTATION MARK ORNAMENT](https://codepoints.net/U+276F)" (that's `\u276f`, or `e2 9d af` in UTF-8).
- Extended right-hand size prompt which auto-hides when necessary to make room for long commands and contains:
  - Duration of previous command in adaptive units (seconds, minutes, hours, days, depending on duration).
  - Current version control branch name.
  - Current version control worktree status using colors that match those used in `git status`:
    - Green dot indicates staged changes.
    - Red dot indicates unstaged changes.
    - Blue dot indicates untracked files.
  - Full version of current working directory (again, abbreviating `$HOME` to `~`).

Nested shells are indicated with additional prompt characters. For example, one nested shell:

![](https://raw.githubusercontent.com/wincent/wincent/media/prompt-shlvl-2.png)

Two nested shells:

![](https://raw.githubusercontent.com/wincent/wincent/media/prompt-shlvl-3.png)

Root shells are indicated with a different color prompt character and the word "root":

![](https://raw.githubusercontent.com/wincent/wincent/media/prompt-root.png)

Nesting within a root shell is indicated like this:

![](https://raw.githubusercontent.com/wincent/wincent/media/prompt-root-shlvl-2.png)

Two nested shells:

![](https://raw.githubusercontent.com/wincent/wincent/media/prompt-root-shlvl-3.png)

If the last command exited with a non-zero status (usually indicative of an error), a yellow exclamation is shown:

![](https://raw.githubusercontent.com/wincent/wincent/media/prompt-error.png)

If there are background processes, a yellow asterisk is shown:

![](https://raw.githubusercontent.com/wincent/wincent/media/prompt-bg.png)

## THIRD-PARTY SCRIPT

- `epr`: CLI EPUB files reader (https://github.com/wustho/epr).
- `speedtest`: a CLI script for testing internet bandwidth using Ookla's speedtest.net (https://github.com/sivel/speedtest-cli).
- `update-firmware`: update firmware from the linux firmware repo which ahs the latest builds (https://github.com/jessfraz/dotfiles/blob/master/bin/update-firmware).
- `update-iwlwifi`: update iwlwifi firmware from intel's linux fork (https://github.com/jessfraz/dotfiles/blob/master/bin/update-iwlwifi).
- `bonsai`: a CLI bonsai tree generator (https://gitlab.com/jallbrit/bonsai.sh).
- `pfetch`: a simple system information displayer (https://github.com/dylanaraps/pfetch).
- `neofetch`: a CLI system information tool (https://github.com/dylanaraps/neofetch).

# INSTALLATION

1. git clone --recursive https://github.com/Z5483/dotfiles
2. ./install [options]

```sh
install zsh     # install zsh config only
install vim     # install vim config only
install all     # install everything
install fonts   # install font files only
install clean   # remove all created symlink files
```

**Note:** The `ln -sf` command will overwrite existing files, but will fail to overwrite existing directories.
> use `test-conflict` script in the `example` directory to see conflicted directories

**Note:** When `./install clean` is executed, it will remove the existing symlink that has identical name as one of file in this repository.

**Note:** Given that `~/.gitconfig` is included with these dotfiles, any local configurations should be written to `~/.gitconfig.local` instead such as:

```sh
git config --file ~/.gitconfig.local user.name "username"
git config --file ~/.gitconfig.local user.email "user@example.com"
```
**Note:** You can also run the script `setup-git-user` in the `example` directory to quickly do the above.

# TROUBLESHOOTING

## Installation Script
If `install` script doesn't work, try again using the following command: `bash
install [options]`.  
If the above doesn't solve your problem, then please create an issue.
