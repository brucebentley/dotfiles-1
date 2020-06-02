function! emanon#mappings#leader#cycle_numbering() abort
	if exists('+relativenumber')
		execute {
					\ '00': 'set relativenumber   | set number',
					\ '01': 'set norelativenumber | set number',
					\ '10': 'set norelativenumber | set nonumber',
					\ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
	else
		set number!
	endif
endfunction

function! emanon#mappings#leader#matchparen() abort
	let l:currwin=winnr()
	if exists('g:loaded_matchparen')
		NoMatchParen
	else
		DoMatchParen
	endif
	execute l:currwin . 'wincmd w'
endfunction

function! emanon#mappings#leader#zap_trailing_whitespaces() abort
	call emanon#functions#substitute('\s\+$', '', '')
endfunction