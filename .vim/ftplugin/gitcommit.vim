if has('folding')
  setlocal nofoldenable
endif

call emanon#functions#spell()

call emanon#plugins#abolish()

" This slows down initialization but it's too damn useful not to have it right
" from the start.
call emanon#autocomplete#deoplete_init()
