function! autocmds#blur_window() abort
	ownsyntax off
	set nolist
endfunction

function! autocmds#focus_window() abort
	if !empty(&ft)
		execute "ownsyntax ".(&ft)
		set list
	endif
endfunction

function! autocmds#idleboot() abort
	augroup Idleboot
		autocmd!
	augroup END

	doautocmd User Defer
	autocmd! User Defer
endfunction
