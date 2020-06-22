function! s:CheckColorScheme() abort
	let s:config_file = expand('~/.config/nvim/.base16')

	if filereadable(s:config_file)
		let s:config = readfile(s:config_file, '', 2)

		if s:config[1] =~# '^dark\|light$'
			execute 'set background=' . s:config[1]
		else
			echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
		endif

		if filereadable(expand('~/.config/nvim/colors/base16-' . s:config[0] . '.vim'))
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
	exec 'highlight LspDiagnosticsError cterm=italic gui=italic ' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsHint cterm=italic gui=italic ' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('ModeMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsInformation cterm=italic gui=italic ' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Conditional')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsWarning cterm=italic gui=italic' .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')

	exec 'highlight LspDiagnosticsErrorSign' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsHintSign' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('ModeMsg')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsInformationSign' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Conditional')), 'fg', 'gui')
	exec 'highlight LspDiagnosticsWarningSign' .
				\ ' guibg=' . synIDattr(synIDtrans(hlID('ColorColumn')), 'bg', 'gui') .
				\ ' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
endfunction

if has('autocmd')
	augroup Color
		autocmd!
		autocmd ColorScheme * call s:SetupHighlights()
		autocmd ColorScheme * call s:SetupLspHighlights()
		autocmd VimEnter,FocusGained * call s:CheckColorScheme()
	augroup END
endif
