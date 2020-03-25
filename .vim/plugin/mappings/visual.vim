
" Visual mode mappings.

"Move cursor by display lines
vnoremap <buffer> j  gj
vnoremap <buffer> k  gk

"remap Escape key
vnoremap '' <Esc>

"Move between windows
vnoremap <C-h> <C-w>h
vnoremap <C-j> <C-w>j
vnoremap <C-k> <C-w>k
vnoremap <C-l> <C-w>l

" Move VISUAL LINE selection within buffer.
vnoremap <silent> K :call emanon#mappings#visual#move_up()<CR>
vnoremap <silent> J :call emanon#mappings#visual#move_down()<CR>
