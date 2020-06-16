nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Tab> za

nnoremap <silent> <leader>n :nohlsearch<CR>

nnoremap <silent> <Leader>zz :%s/\s\+$//e<CR>

nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

nnoremap <silent> <LocalLeader>dd :Gvdiff<CR>
nnoremap <silent> <LocalLeader>dh :diffget //2<CR>
nnoremap <silent> <LocalLeader>dl :diffget //3<CR>

nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

nnoremap <silent> <S-Up> :lprevious<CR>
nnoremap <silent> <S-Down> :lnext<CR>
nnoremap <silent> <S-Left> :lpfile<CR>
nnoremap <silent> <S-Right> :lnfile<CR>

cnoremap <expr> <Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
cnoremap <expr> <S-Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>?<C-r>/' : '<S-Tab>'

nnoremap <evpr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <evpr> j (v:count > 5 ? "m'" . v:count : '') . 'j'
