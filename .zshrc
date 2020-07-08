typeset -A __USER

__USER[BASE16_CONFIG]=$HOME/.zsh/.base16
__USER[BLOCK_CURSOR]=$'\033[2 q'
__USER[LINE_CURSOR]=$'\033[6 q'
__USER[ITALIC_OFF]=$'\033[23m'
__USER[ITALIC_ON]=$'\033[3m'

fpath=(
	$HOME/.zsh/completions
	$fpath
)

HISTSIZE=1000000
HISTFILE="$HOME/.history"
SAVEHIST=$HISTSIZE

setopt AUTO_CD
setopt CORRECT_ALL
setopt EXTENDED_GLOB
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt LIST_PACKED
setopt MENU_COMPLETE
setopt SHARE_HISTORY

source $HOME/.zsh/config/aliases.zsh
source $HOME/.zsh/config/async.zsh
source $HOME/.zsh/config/bindings.zsh
source $HOME/.zsh/config/colors.zsh
source $HOME/.zsh/config/completion.zsh
source $HOME/.zsh/config/functions.zsh
source $HOME/.zsh/config/hash.zsh
source $HOME/.zsh/config/prompt.zsh

source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
source $HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
