nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap Y y$

nnoremap <leader>\ :vsplit<CR>
nnoremap <leader>- :split<CR>

nnoremap <leader>\| <C-w>\|
nnoremap <leader>_ <C-w>_
nnoremap <leader>= <C-w>=

nnoremap <leader>w :write!<CR>
nnoremap <leader>q :quit!<CR>
nnoremap <leader>x :quitall!<CR>

nnoremap <leader>n :nohlsearch<CR>

nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

nnoremap <silent> <LocalLeader>s :syntax sync fromstart<CR>

nnoremap <silent> <Leader>zz :%s/\s\+$//e<CR>

nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

nnoremap <silent> <S-Up> :lprevious<CR>
nnoremap <silent> <S-Down> :lnext<CR>
nnoremap <silent> <S-Left> :lpfile<CR>
nnoremap <silent> <S-Right> :lnfile<CR>

nnoremap <expr> k (v:count > 2 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 2 ? "m'" . v:count : '') . 'j'

cnoremap <expr> <Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
cnoremap <expr> <S-Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>?<C-r>/' : '<S-Tab>'
