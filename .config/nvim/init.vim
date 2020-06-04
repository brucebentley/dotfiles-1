let mapleader="\<Space>"
let maplocalleader="\\"

let g:LoupeCenterResults=0

map <Nop> <Plug>(LoupeN)
nmap <Nop> <Plug>(Loupen)

if filereadable('/usr/bin/python3')
	let g:python3_host_prog='/usr/bin/python3'
endif

if filereadable('/usr/local/lib64/ruby/gems/2.7.0/bin/neovim-ruby-host')
	let g:ruby_host_prog='/usr/local/lib64/ruby/gems/2.7.0/bin/neovim-ruby-host'
endif

nmap <leader>f <Plug>(FerretAckWord)
nmap <leader>s <Plug>(FerretAcks)

if &loadplugins
	if has('packages')
		packadd! command-t
		packadd! deoplete-lsp
		packadd! deoplete.nvim
		packadd! ferret
		packadd! loupe
		packadd! nvim-lsp
		packadd! pinnacle
		packadd! scalpel
		packadd! ultisnips
		packadd! vim-clang-format
		packadd! vim-commentary
		packadd! vim-dispatch
		packadd! vim-easydir
		packadd! vim-eunuch
		packadd! vim-fugitive
		packadd! vim-projectionist
		packadd! vim-repeat
		packadd! vim-surround
		packadd! vim-vinegar
	endif
endif

filetype indent plugin on
syntax on
