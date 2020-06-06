scriptencoding utf-8

set autoindent
set backspace=indent,start,eol

if has('folding')
	set foldmethod=indent
	set foldlevelstart=99
	set foldtext=emanon#settings#foldtext()
endif

set list

set listchars+=extends:»
set listchars+=nbsp:ø
set listchars+=precedes:«
set listchars+=tab:▷┅
set listchars+=trail:•

set fillchars=diff:∙
set fillchars+=eob:\ 
set fillchars+=fold:·
set fillchars+=vert:┃

set number

if exists('+relativenumber')
	set relativenumber
endif


if has('linebreak')
	let &showbreak='↳ '
endif

set display+=lastline

set scrolloff=1

set sidescrolloff=5

set splitbelow
set splitright

if has('termguicolors')
	set termguicolors
endif

set wildmenu
set wildcharm=<C-z>
