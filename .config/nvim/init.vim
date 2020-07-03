let mapleader="\<Space>"
let maplocalleader="\\"

if executable('python3')
	let g:python3_host_prog='python3'
endif

if &loadplugins
	if has('packages')
		packadd! deoplete
		packadd! deoplete-lsp
		packadd! nvim-lsp
		packadd! ultisnips
	endif
endif

filetype indent plugin on
syntax on
