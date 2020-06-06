function! autocmds#blur_window() abort
	ownsyntax off
	set nolist
	if has('conceal')
		set conceallevel=0
	endif
endfunction

function! autocmds#focus_window() abort
	if !empty(&ft)
		execute "ownsyntax ".(&ft)
		set list
		if has('conceal')
			set conceallevel=1
		endif
	endif
endfunction

function! autocmds#idleboot() abort
	augroup Idleboot
		autocmd!
	augroup END

	doautocmd User Defer
	autocmd! User Defer
endfunction
