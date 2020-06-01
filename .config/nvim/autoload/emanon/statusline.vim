scriptencoding utf-8

function! emanon#statusline#gutterpadding() abort
	let l:signcolumn=0
	if exists('+signcolumn')
		if &signcolumn == 'yes'
			let l:signcolumn=2
		elseif &signcolumn == 'auto'
			if exists('*execute')
				let l:signs=execute('sign place buffer=' .bufnr('$'))
			else
				let l:signs=''
				silent! redir => l:signs
				silent execute 'sign place buffer=' . bufnr('$')
				redir END
			end
			if match(l:signs, 'line=') != -1
				let l:signcolumn=2
			endif
		endif
	endif

	let l:minwidth=2
	let l:gutterWidth=max([strlen(line('$')) + 1, &numberwidth, l:minwidth]) + l:signcolumn
	let l:padding=repeat(' ', l:gutterWidth - 1)
	return l:padding
endfunction

function! emanon#statusline#fileprefix() abort
	let l:basename=expand('%:h')
	if l:basename ==# '' || l:basename ==# '.'
		return ''
	elseif has('modify_fname')
		return substitute(fnamemodify(l:basename, ':~:.'), '/$', '', '') . '/'
	else
		return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
	endif
endfunction

function! emanon#statusline#ft() abort
	if strlen(&ft)
		return ',' . &ft
	else
		return ''
	endif
endfunction

function! emanon#statusline#fenc() abort
	if strlen(&fenc) && &fenc !=# 'utf-8'
		return ',' . &fenc
	else
		return ''
	endif
endfunction

function! emanon#statusline#lhs() abort
	let l:line=emanon#statusline#gutterpadding()
	let l:line.=&modified ? '✘ ' : '  '
	return l:line
endfunction

function! emanon#statusline#rhs() abort
	let l:rhs=' '
	if winwidth(0) > 80
		let l:column=virtcol('.')
		let l:width=virtcol('$')
		let l:line=line('.')
		let l:height=line('$')

		let l:padding=len(l:height) - len(l:line)
		if (l:padding)
			let l:rhs.=repeat(' ', l:padding)
		endif

		let l:rhs.='ℓ ' " (Literal, \u2113 "SCRIPT SMALL L").
		let l:rhs.=l:line
		let l:rhs.='/'
		let l:rhs.=l:height
		let l:rhs.=' 𝚌 ' " (Literal, \u1d68c "MATHEMATICAL MONOSPACE SMALL C").
		let l:rhs.=l:column
		let l:rhs.='/'
		let l:rhs.=l:width
		let l:rhs.=' '

		if len(l:column) < 2
			let l:rhs.=' '
		endif
		if len(l:width) < 2
			let l:rhs.=' '
		endif
	endif
	return l:rhs
endfunction

let s:default_lhs_color='Identifier'
let s:async_lhs_color='Constant'
let s:modified_lhs_color='ModeMsg'
let s:emanon_statusline_status_highlight=s:default_lhs_color
let s:async=0

function! emanon#statusline#async_start() abort
	let s:async=1
	call emanon#statusline#check_modified()
endfunction

function! emanon#statusline#async_finish() abort
	let s:async=0
	call emanon#statusline#check_modified()
endfunction

function! emanon#statusline#check_modified() abort
	if &modified && s:emanon_statusline_status_highlight != s:modified_lhs_color
		let s:emanon_statusline_status_highlight=s:modified_lhs_color
		call emanon#statusline#update_highlight()
	elseif !&modified
		if s:async && s:emanon_statusline_status_highlight != s:async_lhs_color
			let s:emanon_statusline_status_highlight=s:async_lhs_color
			call emanon#statusline#update_highlight()
		elseif !s:async && s:emanon_statusline_status_highlight != s:default_lhs_color
			let s:emanon_statusline_status_highlight=s:default_lhs_color
			call emanon#statusline#update_highlight()
		endif
	endif
endfunction

function! emanon#statusline#update_highlight() abort
	if !emanon#pinnacle#active()
		return
	endif

	let l:highlight=pinnacle#italicize('StatusLine')
	execute 'highlight User1 ' . l:highlight

	let l:highlight=pinnacle#italicize('MatchParen')
	execute 'highlight User2 ' . l:highlight

	let l:highlight=pinnacle#extract_highlight('StatusLine')
	execute 'highlight User3 ' . l:highlight

	let l:fg=pinnacle#extract_fg(s:emanon_statusline_status_highlight)
	let l:bg=pinnacle#extract_bg('StatusLine')
	execute 'highlight User4 ' . pinnacle#highlight({'bg': l:bg, 'fg': l:fg})

	execute 'highlight User7 ' .
				\ pinnacle#highlight({
				\   'bg': l:fg,
				\   'fg': pinnacle#extract_fg('Normal'),
				\ })

	let l:bg=pinnacle#extract_fg('Cursor')
	let l:fg=pinnacle#extract_fg('User3')
	execute 'highlight User5 ' .
				\ pinnacle#highlight({
				\   'bg': l:fg,
				\   'fg': l:bg,
				\ })

	execute 'highlight User6 ' .
				\ pinnacle#highlight({
				\   'bg': l:fg,
				\   'fg': l:bg,
				\   'term': 'italic'
				\ })

	highlight clear StatusLineNC
	highlight! link StatusLineNC User1
endfunction
