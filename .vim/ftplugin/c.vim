setlocal shiftwidth=8
setlocal tabstop=8
setlocal cindent
setlocal cinoptions=:0,l1,t0,g0,(0

" This slows down initialization but it's too damn useful not to have it right
" from the start.
call emanon#autocomplete#deoplete_init()
