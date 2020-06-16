function! autocmds#idleboot() abort
	augroup Idleboot
		autocmd!
	augroup END

	doautocmd User Defer
	autocmd! User Defer
endfunction
