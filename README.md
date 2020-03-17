## SCREENSHOT
<img src="screenshot/0001">
<img src="screenshot/0002">

## SYSTEM CONFIGURATION
* `distro`: gentoo
* `wm`: dwm
* `terminal`: st
* `shell`: zsh
* `browser`: surf
* `editor`: neovim
* `font`: Deja Vu Sans Mono

## ZSH

### FUNCTIONS

- `ag`: Transparently wraps the `ag` executable so as to provide a centralized place to set defaults for that command (seeing as it has no "rc" file).
- `bounce`: bounce the macOS Dock icon if the terminal is not in the foreground.
- `color`: change terminal and Vim color scheme.
- `email`: convenience wrapper to spawn (or attach to) a tmux session running `mutt` and `mbsync`.
- `fd`: "find directory" using fast `bfs` and `fzf`; automatically `cd`s into the selected directory.
- `fh`: "find [in] history"; selecting a history item inserts it into the command line but does not execute it.
- `history`: overrides the (tiny) default history count.
- `jump` (aliased to `j`): to jump to hashed directories.
- `regmv`: bulk-rename files (eg. `regmv '/\.tif$/.tiff/' *`).
- `scratch`: create a random temporary scratch directory and `cd` into it.
- `tick`: moves an existing time warp (eg. `tick +1h`); see `tw` below for a description of time warp.
- `tmux`: wrapper that reattches to pre-existing sessions, or creates new ones based on the current directory name; additionally, looks for a `.tmux` file to set up windows and panes (note that the first time a given `.tmux` file is encountered the wrapper asks the user whether to trust or skip it).
- `tw` ("time warp"): overrides `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` (eg. `tw -1d`).

### PROMPT
#### Prompt

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

## INSTALL
```
./install.sh will install everything on the local system by creating symbolic links to the target location

**Note:** The `ln -sf` command will overwrite existing files, but will fail to overwrite existing directories.
