typeset -A __EMANON

autoload -Uz add-zsh-hook compinit vcs_info

HISTSIZE=1000000
HISTFILE="$HOME/.history"
SAVEHIST=$HISTSIZE

setopt AUTO_CD
setopt CORRECT
setopt CORRECT_ALL
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt LIST_PACKED
setopt MENU_COMPLETE
setopt SHARE_HISTORY

source $HOME/.zsh/config/aliases.zsh
source $HOME/.zsh/config/bindings.zsh
source $HOME/.zsh/config/colors.zsh
source $HOME/.zsh/config/completion.zsh
source $HOME/.zsh/config/exports.zsh
source $HOME/.zsh/config/wrappers.zsh
source $HOME/.zsh/config/path.zsh
source $HOME/.zsh/config/prompt.zsh

source $HOME/.zsh/plugin/fzf/shell/completion.zsh
source $HOME/.zsh/plugin/fzf/shell/key-bindings.zsh

source $HOME/.zsh/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

source $HOME/.zsh/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
