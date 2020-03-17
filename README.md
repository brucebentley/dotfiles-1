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
* `music player`: ncmpcpp/spotify
* `font`: Deja Vu Sans Mono

## SHELL FUNCTIONS
- `ag`: Transparently wraps the `ag` executable so as to provide a centralized place to set defaults for that command (seeing as it has no "rc" file).
- `color`: change terminal and Vim color scheme.
- `fd`: "find directory" using fast `bfs` and `fzf`; automatically `cd`s into the selected directory.
- `fh`: "find [in] history"; selecting a history item inserts it into the command line but does not execute it.
- `history`: overrides the (tiny) default history count.
- `jump` (aliased to `j`): to jump to hashed directories.
- `regmv`: bulk-rename files (eg. `regmv '/\.tif$/.tiff/' *`).
- `scratch`: create a random temporary scratch directory and `cd` into it.
- `tick`: moves an existing time warp (eg. `tick +1h`); see `tw` below for a description of time warp.
- `tmux`: wrapper that reattches to pre-existing sessions, or creates new ones based on the current directory name; additionally, looks for a `.tmux` file to set up windows and panes (note that the first time a given `.tmux` file is encountered the wrapper asks the user whether to trust or skip it).
- `tw` ("time warp"): overrides `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` (eg. `tw -1d`).

## INSTALL
```
./install.sh will install everything on the local system by creating symbolic links to the target location
```

**Note:** The `ln -sf` command will overwrite existing files, but will fail to overwrite existing directories.