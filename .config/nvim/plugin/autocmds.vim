if has('autocmd')
	augroup EmanonAutocmds
		autocmd!

		if exists('+winhighlight')
			autocmd BufEnter,FocusGained,VimEnter,WinEnter * set winhighlight=
			autocmd FocusLost,WinLeave * set winhighlight=CursorLineNr:LineNr,EndOfBuffer:ColorColumn,IncSearch:ColorColumn,Normal:ColorColumn,NormalNC:ColorColumn,SignColumn:ColorColumn
		endif

		autocmd BufEnter,InsertLeave,VimEnter * setlocal cursorline
		autocmd BufLeave,InsertEnter * setlocal nocursorline

		autocmd BufEnter,FocusGained,VimEnter,WinEnter * call emanon#autocmds#focus_window()
		autocmd BufLeave,FocusLost,WinLeave * call emanon#autocmds#blur_window()

		if exists('##TextYankPost')
			autocmd TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank('Substitute', 200)
		endif
	augroup END

	augroup EmanonIdleboot
		autocmd!
		if has('vim_starting')
			autocmd CursorHold,CursorHoldI * call emanon#autocmds#idleboot()
		endif
	augroup END
endif
