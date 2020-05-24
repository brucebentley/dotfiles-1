function! s:Config()
	nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>

	if exists('+signcolumn')
		setlocal signcolumn=auto
	endif
endfunction

augroup EmanonLanguageClientAutocmds
	autocmd!
	autocmd FileType * call s:Config()
augroup END
