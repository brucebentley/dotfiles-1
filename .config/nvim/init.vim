let mapleader="\<Space>"
let maplocalleader="\\"

if filereadable('/usr/bin/python3')
	let g:python3_host_prog='/usr/bin/python3'
endif

if &loadplugins
	if has('packages')
		packadd! deoplete
		packadd! deoplete-lsp
		packadd! nvim-lsp
		packadd! ultisnips
		packadd! vim-vinegar
	endif
endif

filetype indent plugin on
syntax on
