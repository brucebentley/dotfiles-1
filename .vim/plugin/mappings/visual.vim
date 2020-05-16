vnoremap j gj
vnoremap k gk

vnoremap <C-h> <C-w>h
vnoremap <C-j> <C-w>j
vnoremap <C-k> <C-w>k
vnoremap <C-l> <C-w>l

vnoremap <silent> K :call emanon#mappings#visual#move_up()<CR>
vnoremap <silent> J :call emanon#mappings#visual#move_down()<CR>
