function! s:SetC()
	noautocmd set filetype=c

	if exists(':LanguageClientStart') == 2
		LanguageClientStart
	endif
endfunction

autocmd BufNewFile,Bufread *.c,*.h call s:SetC()
