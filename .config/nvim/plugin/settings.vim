scriptencoding utf-8

set autoindent
set backspace=indent,start,eol

set scrolloff=1
set sidescrolloff=5

set number
set relativenumber

if has('folding')
	set foldmethod=indent
	set foldlevelstart=99
	set foldtext=settings#foldtext()
endif

if has('linebreak')
	let &showbreak='↳ '
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

set shortmess=I

set display+=lastline

set splitbelow
set splitright

if has('termguicolors')
	set termguicolors
endif

set wildmenu
set wildcharm=<C-z>
