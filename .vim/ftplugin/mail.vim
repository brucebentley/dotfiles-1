" See also: after/ftplugin/mail.vim.

setlocal nolist

call emanon#functions#spell()

setlocal synmaxcol=0

nnoremap <buffer> j gj
nnoremap <buffer> k gk

call emanon#autocomplete#deoplete_init()<Paste>
