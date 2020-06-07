let mapleader="\<Space>"
let maplocalleader="\\"

if filereadable('/usr/bin/python3')
	let g:python3_host_prog='/usr/bin/python3'
endif

if &loadplugins
	if has('packages')
		packadd! deoplete-lsp
		packadd! deoplete.nvim
		packadd! ferret
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
