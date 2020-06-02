function! emanon#defer#defer(evalable) abort
	if has('autocmd') && has('vim_starting')
		execute 'autocmd User emanonDefer ' . a:evalable
	else
		execute a:evalable
	endif
endfunction
