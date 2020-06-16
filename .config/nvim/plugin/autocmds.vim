if has('autocmd')
	augroup Autocmds
		autocmd!
		if exists('+winhighlight')
			autocmd BufEnter,FocusGained,VimEnter,WinEnter * set winhighlight=
			autocmd FocusLost,WinLeave * set winhighlight=CursorLineNr:LineNr,EndOfBuffer:ColorColumn,IncSearch:ColorColumn,Normal:ColorColumn,NormalNC:ColorColumn,SignColumn:ColorColumn
		endif

		autocmd BufEnter,InsertLeave,VimEnter * setlocal cursorline
		autocmd BufLeave,InsertEnter * setlocal nocursorline

		autocmd BufEnter,FocusGained,VimEnter,WinEnter * set list | execute 'ownsyntax ' . (&ft)
		autocmd BufLeave,FocusLost,WinLeave * set nolist | ownsyntax off

		if exists('##TextYankPost')
			autocmd TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank('Substitute', 200)
		endif
	augroup END

	augroup Idleboot
		autocmd!
		if has('vim_starting')
			autocmd InsertEnter * call autocomplete#deoplete_init()
		endif
	augroup END
endif
