let mapleader="\<Space>"
let maplocalleader="\\"

set runtimepath+=~/.zsh/vendor/fzf

if filereadable('/usr/bin/python3')
	let g:python3_host_prog='/usr/bin/python3'
endif

if &loadplugins
	if has('packages')
		packadd! base16-vim
		packadd! deoplete-lsp
		packadd! deoplete.nvim
		packadd! fzf.vim
		packadd! nvim-lsp
		packadd! pinnacle
		packadd! ultisnips
		packadd! vim-clang-format
		packadd! vim-fugitive
		packadd! vim-vinegar
	endif
endif

filetype indent plugin on
syntax on
