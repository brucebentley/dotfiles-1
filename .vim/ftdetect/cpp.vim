function! s:SetC()
	noautocmd set filetype=cpp

	if exists(':LanguageClientStart') == 2
		LanguageClientStart
	endif
endfunction

autocmd BufNewFile,Bufread *.cpp,*.hpp call s:SetC()
