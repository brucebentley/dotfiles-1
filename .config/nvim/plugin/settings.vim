scriptencoding utf-8

set cindent
set cinoptions=:0,l1,t0,g0,(0
set autoread
set backspace=indent,start,eol

set history=10000

set timeoutlen=1000
set ttimeoutlen=100

if exists('$SUDO_USER')
	set nobackup
	set nowritebackup
else
	set backupdir=~/.config/nvim/tmp/backup
	set backupdir+=.
endif

if exists('&belloff')
	set belloff=all
endif

if exists('+colorcolumn')
	let &l:colorcolumn='+' . join(range(0, 254), ',+')
endif

set cursorline
set diffopt+=foldcolumn:0

if exists('$SUDO_USER')
	set noswapfile
else
	set directory=~/.config/nvim/tmp/swap
	set directory+=.
endif

set noexpandtab

if has('folding')
	if has('windows')
		set fillchars=diff:∙
		set fillchars+=fold:·
		set fillchars+=vert:┃
	endif

	set fillchars+=eob:\ 

	set foldmethod=indent
	set foldlevelstart=99
	set foldtext=emanon#settings#foldtext()
endif

set hidden

if exists('&completeopt')
	set completeopt=
endif

if exists('&inccommand')
	set inccommand=split
endif

set laststatus=2
set lazyredraw

if has('linebreak')
	set linebreak
endif

set tabpagemax=50

set list
set listchars=nbsp:ø
set listchars+=tab:▷┅
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set modeline
set modelines=5
set nojoinspaces
set number

if exists('+relativenumber')
	set relativenumber
endif

set scrolloff=1

set shell=zsh
set shiftround
set shiftwidth=8
set shortmess+=A
set shortmess+=I
set shortmess+=O
set shortmess+=T
set shortmess+=W
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
set smarttab

set tabstop=8
set softtabstop=8

if has('syntax')
	set spellcapcheck=
endif

if has('windows')
	set splitbelow
endif

if has('vertsplit')
	set splitright
endif

if exists('&swapsync')
	set swapsync=
endif
set switchbuf=usetab

if has('syntax')
	set synmaxcol=200
endif

if has('termguicolors')
	set termguicolors
endif

set textwidth=80

if has('persistent_undo')
	if exists('$SUDO_USER')
		set noundofile
	else
		set undodir=~/.config/nvim/tmp/undo
		set undodir+=.
		set undofile
	endif
endif

set updatecount=80
set updatetime=200

if has('viminfo')
	let s:viminfo='viminfo'
elseif has('shada')
	let s:viminfo='shada'
endif

if exists('s:viminfo')
	if exists('$SUDO_USER')
		execute 'set ' . s:viminfo . '='
	else
		execute 'set ' . s:viminfo . "='0,<0,f0,n~/.config/nvim/tmp/" . s:viminfo

		if !empty(glob('~/.vim/tmp/' . s:viminfo))
			if !filereadable(expand('~/.config/nvim/tmp/' . s:viminfo))
				echoerr 'warning: ~/.config/nvim/tmp/' . s:viminfo . ' exists but is not readable'
			endif
		endif
	endif
endif

if has('mksession')
	set viewdir=~/.config/nvim/tmp/view
	set viewoptions-=options
	set sessionoptions-=options
endif

if has('virtualedit')
	set virtualedit=block
endif
set visualbell t_vb=
set whichwrap=b,h,l,s,<,>,[,],~
set wildcharm=<C-z>
if has('wildignore')
	set wildignore+=*.o,*.rej
endif
if has('wildmenu')
	set wildmenu
endif
set wildmode=longest:full,full
