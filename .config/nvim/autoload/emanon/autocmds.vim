function! emanon#autocmds#blur_window() abort
	ownsyntax off
	set nolist
	if has('conceal')
		set conceallevel=0
	endif
endfunction

function! emanon#autocmds#focus_window() abort
	if !empty(&ft)
		execute "ownsyntax ".(&ft)
		set list
		if has('conceal')
			set conceallevel=1
		endif
	endif
endfunction

function! emanon#autocmds#idleboot() abort
	augroup EmanonIdleboot
		autocmd!
	augroup END

	doautocmd User EmanonDefer
	autocmd! User EmanonDefer
endfunction
