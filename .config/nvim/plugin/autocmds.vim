if has('autocmd')
	function! s:emanonAutocmds()
		augroup emanonAutocmds
			autocmd!

			autocmd VimResized * execute "normal! \<c-w>="

			autocmd VimEnter * autocmd WinEnter * let w:created=1
			autocmd VimEnter * let w:created=1

			autocmd InsertLeave * set nopaste

			if exists('+winhighlight')
				autocmd BufEnter,FocusGained,VimEnter,WinEnter * set winhighlight=
				autocmd FocusLost,WinLeave * set winhighlight=CursorLineNr:LineNr,EndOfBuffer:ColorColumn,IncSearch:ColorColumn,Normal:ColorColumn,NormalNC:ColorColumn,SignColumn:ColorColumn
				if exists('+colorcolumn')
					autocmd BufEnter,FocusGained,VimEnter,WinEnter * if emanon#autocmds#should_colorcolumn() | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
				endif
			elseif exists('+colorcolumn')
				autocmd BufEnter,FocusGained,VimEnter,WinEnter * if emanon#autocmds#should_colorcolumn() | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
				autocmd FocusLost,WinLeave * if emanon#autocmds#should_colorcolumn() | let &l:colorcolumn=join(range(1, 255), ',') | endif
			endif
			autocmd InsertLeave,VimEnter,WinEnter * if emanon#autocmds#should_cursorline() | setlocal cursorline | endif
			autocmd InsertEnter,WinLeave * if emanon#autocmds#should_cursorline() | setlocal nocursorline | endif

			if has('mksession')
				autocmd BufWritePost,BufLeave,WinLeave ?* if emanon#autocmds#should_mkview() | call emanon#autocmds#mkview() | endif
				if has('folding')
					autocmd BufWinEnter ?* if emanon#autocmds#should_mkview() | silent! loadview | execute 'silent! ' . line('.') . 'foldopen!' | endif
				else
					autocmd BufWinEnter ?* if emanon#autocmds#should_mkview() | silent! loadview | endif
				endif
			elseif has('folding')
				autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"" | execute 'silent! ' . line("'\"") . 'foldopen!' | endif
			else
				autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"" | endif
			endif
		augroup END
	endfunction

	call s:emanonAutocmds()
endif
