let mapleader="\<Space>"
let maplocalleader="\\"

set runtimepath+=~/.zsh/plugin/fzf

if filereadable('/usr/bin/python3')
	let g:python3_host_prog='/usr/bin/python3'
endif

if &loadplugins
	if has('packages')
		packadd! base16-vim
		packadd! deoplete
		packadd! deoplete-lsp
		packadd! fzf-vim
		packadd! nvim-lsp
		packadd! ultisnips
		packadd! vim-fugitive
		packadd! vim-vinegar
	endif
endif

filetype indent plugin on
syntax on
