# Screenshot
![](https://raw.githubusercontent.com/Z5483/dotfiles/media/desktop-tiling.png)
![](https://raw.githubusercontent.com/Z5483/dotfiles/media/desktop-floating.png)

# System Configuration

* `distro`: gentoo
* `wm`: dwm
* `terminal`: st
* `shell`: zsh
* `browser`: surf
* `editor`: neovim
* `music player`: mpd/ncmpcpp, spotify
* `font`: DejaVu Sans Mono

# Keyboard Mappings

**[xcape](https://github.com/alols/xcape)** and **[setxkbmap](https://github.com/freedesktop/xorg-setxkbmap)** are used for the following mappings:

- Make Caps Lock generate Escape (when tapped and released on its own) and Super (when chorded with another key).
- Make Space generate Ctrl when chorded with another key.
- Toggle Caps Lock by pressing both shift keys together.
  - While Caps Lock is on, press either shift key to turn Caps Locks off.

# ZSH

Heavily inspired by https://github.com/wincent/wincent

## Shell Functions

- `color`: change terminal and Vim color scheme.
- `fd`: "find directory" using fast `bfs` and `sk`; automatically `cd`s into the selected directory.
- `fh`: "find [in] history"; selecting a history item inserts it into the command line but does not execute it.
- `scratch`: create a random temporary scratch directory and `cd` into it.
- `tmux`: wrapper that reattches to pre-existing sessions, or creates new ones based on the current directory name; additionally, looks for a `.tmux` file to set up windows and panes (note that the first time a given `.tmux` file is encountered the wrapper asks the user whether to trust or skip it).
- `vifm`: wrapper that utilizes [ueberzug](https://github.com/seebye/ueberzug) to display media previews

## VI Mode

| State         | Cursor Shape       |
| ------------- | ------------------ |
| `Normal`      | `block (█)`        |
| `Insert`      | `vertial bar (\|)` |
| `Visual`      | `block (█)`        |

**Note:** the cursor shapeshifting function does not work on the console.

## Prompt

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

## Third-Party Script

- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy): improve quality of diff.

# Dependencies
- [git](https://github.com/git/git) => 1.8.2
- [Neovim](https://github.com/neovim/neovim) => 0.4.3 or [Vim](https://github.com/vim/vim) => 8.0 with Ruby and Python support
- [tmux](https://github.com/tmux/tmux) => 2.8
- [vifm](https://github.com/vifm/vifm) => 0.8
  - [ueberzug](https://github.com/seebye/ueberzug)(optional) - for image preview
  - [epub-thumbnailer](https://github.com/marianosimone/epub-thumbnailer)(optional) - for displaying cover of epub file
  - [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer)(optional) - for video thumbnail preview
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
