scriptencoding utf-8

set backspace=indent,start,eol

set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

set scrolloff=1
set sidescrolloff=5

set number
set relativenumber

if has('folding')
	set foldmethod=indent
	set foldlevelstart=99
endif

if exists('&inccommand')
	set inccommand=split
endif

if has('showcmd')
	set noshowcmd
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
set fillchars+=eob:\ |
set fillchars+=fold:·
set fillchars+=vert:┃

set completeopt=menuone
set completeopt+=noinsert
set completeopt+=noselect

set shortmess=I
set shortmess+=c

set display+=lastline

set splitbelow
set splitright

set wildmenu
set wildcharm=<C-z>

set termguicolors

if exists('$SUDO_USER')
	set nobackup
	set noswapfile
	set noundofile
	set nowritebackup
else
	set backupdir=/tmp/vim
	set directory=/tmp/vim
	set undodir=/tmp/vim
	set undofile
endif
