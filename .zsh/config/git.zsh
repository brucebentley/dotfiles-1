zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green}●%f"
zstyle ':vcs_info:*' unstagedstr "%F{red}●%f"
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] '
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] '

function +vi-git-untracked() {
	emulate -L zsh

	if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
		hook_com[unstaged]+="%F{blue}●%f"
	fi
}

function -record-command() {
	__EMANON[LAST_COMMAND]="$2"
}
add-zsh-hook preexec -record-command

function -maybe-show-vcs-info() {
	local LAST="$__EMANON[LAST_COMMAND]"

	__EMANON[LAST_COMMAND]="<unset>"
	if [[ $LAST[(w)1] =~ "cd|cp|rm|mv|touch|git" ]]; then
		vcs_info
	fi
}
add-zsh-hook precmd -maybe-show-vcs-info
