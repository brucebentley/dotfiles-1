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

let g:LanguageClient_useFloatingHover=1
let g:LanguageClient_hoverPreview='Always'
let g:LanguageClient_diagnosticsDisplay={
			\   1: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
			\   2: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
			\   3: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
			\   4: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
			\ }
let g:LanguageClient_useVirtualText='Diagnostics'

let g:LanguageClient_rootMarkers={}
let g:LanguageClient_serverCommands={}

if exists('$DEBUG_LC_LOGFILE')
	let g:LanguageClient_loggingFile=$DEBUG_LC_LOGFILE
	let g:LanguageClient_serverStderr=$DEBUG_LC_LOGFILE
	let g:LanguageClient_loggingLevel='DEBUG'
endif

if executable('ccls')
	if exists('$DEBUG_LC_LOGFILE')
		let s:debug_arg=[
					\ '-v=2',
					\ '-log-file-append',
					\ '--log-file='. $DEBUG_LC_LOGFILE,
					\ ]
	else
		let s:debug_arg=[]
	endif
	let s:ccl_lsp=extend([exepath('ccls')], s:debug_arg)
endif

let s:ccl_filetypes=[
			\ 'c',
			\ 'cpp',
			\ ]

if exists('s:ccl_lsp')
	for s:ccl_filetype in s:ccl_filetypes
		let g:LanguageClient_rootMarkers[s:ccl_filetype]=['Makefile']
		let g:LanguageClient_serverCommands[s:ccl_filetype]=s:ccl_lsp
	endfo
endif

let g:LanguageClient_settingsPath = '~/.vim/settings.json'
let g:LanguageClient_diagnosticsList='Location'

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
		packadd! LanguageClient-neovim
		packadd! command-t
		packadd! ferret
		packadd! loupe
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
