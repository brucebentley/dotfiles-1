if &term =~# 'screen' || &term =~# 'tmux' || &term =~# 'xterm'
	let g:CommandTCancelMap=['<ESC>']
	let g:CommandTSelectNextMap = ['<C-n>', '<C-j>']
	let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>']
endif

let g:CommandTEncoding='UTF-8'
let g:CommandTFileScanner='watchman'
let g:CommandTMaxHeight=30
let g:CommandTInputDebounce=50
let g:CommandTMaxCachedDirectories=20
let g:CommandTMaxFiles=5000000
let g:CommandTRecursiveMatch=0
let g:CommandTScanDotDirectories=1
let g:CommandTTraverseSCM='pwd'
let g:CommandTWildIgnore=&wildignore
let g:CommandTWildIgnore.=',*/.git/*'
