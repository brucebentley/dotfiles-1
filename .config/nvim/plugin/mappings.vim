nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <leader>w :write!<CR>
nnoremap <silent> <leader>q :quit!<CR>
nnoremap <silent> <leader>x :quitall!<CR>
nnoremap <silent> <leader>n :nohlsearch<CR>
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
