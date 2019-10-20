call emanon#functions#plaintext()

call emanon#autocomplete#deoplete_init()

setlocal synmaxcol=0

if bufname(bufnr('%')) == '__LanguageClient__'
  setlocal nonumber
  setlocal norelativenumber
endif
