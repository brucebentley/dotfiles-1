if has('autocmd')
	augroup emanonAutocmds
		autocmd!

		if exists('+winhighlight')
			autocmd BufEnter,FocusGained,VimEnter,WinEnter * set winhighlight=
			autocmd FocusLost,WinLeave * set winhighlight=CursorLineNr:LineNr,EndOfBuffer:ColorColumn,IncSearch:ColorColumn,Normal:ColorColumn,NormalNC:ColorColumn,SignColumn:ColorColumn
		endif

		autocmd BufEnter,InsertLeave,VimEnter * setlocal cursorline
		autocmd BufLeave,InsertEnter * setlocal nocursorline

		autocmd BufEnter,FocusGained,VimEnter,WinEnter * call emanon#autocmds#focus_window()
		autocmd BufLeave,FocusLost,WinLeave * call emanon#autocmds#blur_window()

	augroup END
endif
