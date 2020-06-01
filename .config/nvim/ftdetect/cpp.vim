function! s:SetC()
	noautocmd set filetype=cpp
endfunction

autocmd BufNewFile,Bufread *.cpp,*.hpp call s:SetC()
