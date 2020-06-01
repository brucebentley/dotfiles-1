let mapleader="\<Space>"
let maplocalleader="\\"

let g:LoupeCenterResults=0

map <Nop> <Plug>(LoupeN)
nmap <Nop> <Plug>(Loupen)

let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMapJumpNextSibling='<Nop>'

let g:NERDTreeCaseSensitiveSort=1

let g:loaded_netrw=1
let g:loaded_netrwPlugin=1

let g:dispatch_no_maps=1

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
		packadd! ferret
		packadd! loupe
		packadd! nvim-lsp
		packadd! pinnacle
		packadd! scalpel
		packadd! ultisnips
		packadd! vim-commentary
		packadd! vim-dispatch
		packadd! vim-easydir
		packadd! vim-eunuch
		packadd! vim-fugitive
		packadd! vim-projectionist
		packadd! vim-repeat
		packadd! vim-surround
	else
		source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
		call pathogen#infect('pack/bundle/opt/{}')
	endif
endif

filetype indent plugin on
syntax on
