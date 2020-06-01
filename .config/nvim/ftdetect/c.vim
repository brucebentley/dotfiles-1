function! s:SetC()
	noautocmd set filetype=c
endfunction

autocmd BufNewFile,Bufread *.c,*.h call s:SetC()
