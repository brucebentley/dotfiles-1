fpath=(
	"$HOME/.zsh/completions"
	"$HOME/.zsh/config"
	$fpath
)

setopt AUTO_CD
setopt CORRECT_ALL
setopt EXTENDED_GLOB
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt LIST_PACKED
setopt MENU_COMPLETE
setopt SHARE_HISTORY

source "$HOME/.zsh/config/aliases.zsh"
source "$HOME/.zsh/config/bindings.zsh"
source "$HOME/.zsh/config/colors.zsh"
source "$HOME/.zsh/config/completion.zsh"
source "$HOME/.zsh/config/functions.zsh"
source "$HOME/.zsh/config/hash.zsh"
source "$HOME/.zsh/config/prompt.zsh"

source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
