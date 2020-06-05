scriptencoding utf-8

set autoindent
set backspace=indent,start,eol

set noexpandtab

if has('folding')
	set foldmethod=indent
	set foldlevelstart=99
	set foldtext=emanon#settings#foldtext()
endif

if exists('&inccommand')
	set inccommand=split
endif

set lazyredraw

if has('linebreak')
	set linebreak
endif

set list
set fillchars+=eob:\ 
set listchars+=extends:»
set listchars+=nbsp:ø
set listchars+=precedes:«
set listchars+=tab:▷┅
set listchars+=trail:•
set nojoinspaces

set number

if exists('+relativenumber')
	set relativenumber
endif

set scrolloff=1

set shortmess+=I
set shortmess+=O
set shortmess+=T
set shortmess+=a
set shortmess+=c
set shortmess+=o
set shortmess+=t

if has('linebreak')
	let &showbreak='↳ '
endif

if has('showcmd')
	set noshowcmd
endif

set display+=lastline

set sidescroll=0
set sidescrolloff=5

set tabstop=8
set softtabstop=8

if has('windows')
	set splitbelow
endif

if has('vertsplit')
	set splitright
endif

if has('termguicolors')
	set termguicolors
endif

set textwidth=80

set whichwrap=b,h,l,s,<,>,[,],~

if has('wildmenu')
	set wildmenu
endif

set wildcharm=<C-z>
