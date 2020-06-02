function s:RemoveBg(group)
	if !emanon#pinnacle#active()
		return
	endif

	let l:highlight=filter(pinnacle#dump(a:group), 'v:key != "bg"')
	execute 'highlight! clear ' . a:group
	execute 'highlight! ' . a:group . ' ' . pinnacle#highlight(l:highlight)
endfunction

function s:CheckColorScheme()
	if !has('termguicolors')
		let g:base16colorspace=256
	endif

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

	if emanon#pinnacle#active()
		execute 'highlight Comment ' . pinnacle#italicize('Comment')
	endif

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

	if emanon#pinnacle#active()
		highlight clear CursorLineNr
		execute 'highlight CursorLineNr ' . pinnacle#extract_highlight('DiffText')
	endif

	highlight clear DiffDelete
	highlight link DiffDelete Conceal
	highlight clear VertSplit
	highlight link VertSplit LineNr

	highlight link vimUserFunc NONE
	highlight link NERDTreeFile NONE

	for l:group in ['DiffAdded', 'DiffFile', 'DiffNewFile', 'DiffLine', 'DiffRemoved']
		call s:RemoveBg(l:group)
	endfor

	highlight clear DiffAdd
	highlight clear DiffChange
	highlight clear DiffText

	if emanon#pinnacle#active()
		let l:highlight=pinnacle#italicize('ModeMsg')
		execute 'highlight User8 ' . l:highlight
	endif

	doautocmd ColorScheme
endfunction

if has('autocmd')
	augroup emanonAutocolor
		autocmd!
		autocmd FocusGained * call s:CheckColorScheme()
	augroup END
endif

call s:CheckColorScheme()