nnoremap <silent> <leader>n :noh<CR>

nnoremap <silent> <Leader>r :call emanon#mappings#leader#cycle_numbering()<CR>

nnoremap <silent> <Leader>zz :%s/\s\+$//e<CR>

nnoremap <silent> <LocalLeader>dd :Gvdiff<CR>
nnoremap <silent> <LocalLeader>dh :diffget //2<CR>
nnoremap <silent> <LocalLeader>dl :diffget //3<CR>

nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>
