function! s:CheckColorScheme() abort
	let s:config_file = expand('~/.config/nvim/.base16')

	if filereadable(s:config_file)
		let s:config = readfile(s:config_file, '', 2)

		if s:config[1] =~# '^dark\|light$'
			execute 'set background=' . s:config[1]
		else
			echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
		endif

		if filereadable(expand('~/.config/nvim/pack/bundle/opt/base16-vim/colors/base16-' . s:config[0] . '.vim'))
			execute 'colorscheme base16-' . s:config[0]
		else
			echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
		endif
	else
		set background=dark
		colorscheme base16-default-dark
	endif

	doautocmd ColorScheme
endfunction

function! s:SetupHighlights() abort
	highlight clear Comment
	highlight Comment cterm=italic ctermbg=8 gui=italic guifg=#585858

	if &background ==# 'light'
		let s:conceal_term_fg=249
		let s:conceal_gui_fg='Grey70'
	else
		let s:conceal_term_fg=239
		let s:conceal_gui_fg='Grey30'
	endif

	highlight clear Conceal
	execute 'highlight Conceal ' .
				\ 'ctermfg=' . s:conceal_term_fg
				\ 'guifg=' . s:conceal_gui_fg

	highlight clear CursorLineNr
	highlight link CursorLineNr DiffText

	highlight EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

	highlight clear NonText
	highlight link NonText Conceal

	highlight clear Pmenu
	highlight link Pmenu Visual

	highlight clear VertSplit
	highlight link Vertsplit LineNr
endfunction

function! s:SetupLspHighlights() abort
	highlight LspDiagnosticsError cterm=italic ctermfg=1 gui=italic guifg=#ab4642
	highlight LspDiagnosticsHint cterm=italic ctermfg=2 gui=italic guifg=#a1b56c
	highlight LspDiagnosticsInformation cterm=italic ctermfg=5 gui=italic guifg=#ba8baf
	highlight LspDiagnosticsWarning cterm=italic ctermfg=3 gui=italic guifg=#f7ca88

	highlight LspDiagnosticsErrorSign guifg=#ab4642 guibg=#282828
	highlight LspDiagnosticsHintSign guifg=#a1b56c guibg=#282828
	highlight LspDiagnosticsInformationSign guifg=#ba8baf guibg=#282828
	highlight LspDiagnosticsWarningSign guifg=#f7ca88 guibg=#282828
endfunction

if has('autocmd')
	augroup Color
		autocmd!
		autocmd ColorScheme * call s:SetupHighlights()
		autocmd ColorScheme * call s:SetupLspHighlights()
		autocmd VimEnter,FocusGained * call s:CheckColorScheme()
	augroup END
endif
