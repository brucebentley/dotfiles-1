function s:CheckColorScheme() abort
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

function s:SetupHighlights() abort
	execute 'highlight Comment ' . pinnacle#italicize('Comment')

	highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

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

	highlight clear NonText
	highlight link NonText Conceal

	highlight clear CursorLineNr
	execute 'highlight CursorLineNr ' . pinnacle#extract_highlight('DiffText')

	highlight clear Pmenu
	highlight link Pmenu Visual

	highlight clear VertSplit
	highlight link Vertsplit LineNr
endfunction

function s:SetupLspHighlights() abort
	execute 'highlight LspDiagnosticsError ' . pinnacle#decorate('italic', 'WarningMsg')
	execute 'highlight LspDiagnosticsHint ' . pinnacle#decorate('italic', 'ModeMsg')
	execute 'highlight LspDiagnosticsInformation ' . pinnacle#decorate('italic', 'Conditional')
	execute 'highlight LspDiagnosticsWarning ' . pinnacle#decorate('italic', 'Type')

	execute 'highlight LspDiagnosticsErrorSign ' . pinnacle#highlight({
				\   'bg': pinnacle#extract_bg('ColorColumn'),
				\   'fg': pinnacle#extract_fg('WarningMsg')
				\ })
	execute 'highlight LspDiagnosticsHintSign ' . pinnacle#highlight({
				\   'bg': pinnacle#extract_bg('ColorColumn'),
				\   'fg': pinnacle#extract_fg('ModeMsg')
				\ })
	execute 'highlight LspDiagnosticsInformationSign ' . pinnacle#highlight({
				\   'bg': pinnacle#extract_bg('ColorColumn'),
				\   'fg': pinnacle#extract_fg('Conditional'),
				\ })
	execute 'highlight LspDiagnosticsWarningSign ' . pinnacle#highlight({
				\   'bg': pinnacle#extract_bg('ColorColumn'),
				\   'fg': pinnacle#extract_fg('Type')
				\ })
endfunction


if has('autocmd')
	augroup AutoColor
		autocmd!
		autocmd ColorScheme * call s:SetupHighlights()
		autocmd ColorScheme * call s:SetupLspHighlights()
		autocmd FocusGained * call s:CheckColorScheme()
	augroup END
endif

call s:CheckColorScheme()
