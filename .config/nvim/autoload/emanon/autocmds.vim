let g:emanonColorColumnBufferNameBlacklist = []
let g:emanonColorColumnFileTypeBlacklist = ['command-t', 'diff', 'fugitiveblame', 'netrw']
let g:emanonCursorlineBlacklist = ['command-t']
let g:emanonMkviewFiletypeBlacklist = ['diff', 'gitcommit']

function! emanon#autocmds#attempt_select_last_file() abort
	let l:previous=expand('#:t')
	if l:previous !=# ''
		call search('\v<' . l:previous . '>')
	endif
endfunction

function! emanon#autocmds#should_colorcolumn() abort
	if index(g:emanonColorColumnBufferNameBlacklist, bufname(bufnr('%'))) != -1
		return 0
	endif
	return index(g:emanonColorColumnFileTypeBlacklist, &filetype) == -1
endfunction

function! emanon#autocmds#should_cursorline() abort
	return index(g:emanonCursorlineBlacklist, &filetype) == -1
endfunction

function! emanon#autocmds#should_mkview() abort
	return
				\ &buftype ==# '' &&
				\ index(g:emanonMkviewFiletypeBlacklist, &filetype) == -1 &&
				\ !exists('$SUDO_USER')
endfunction

function! emanon#autocmds#mkview() abort
	try
		if exists('*haslocaldir') && haslocaldir()
			cd -
			mkview
			lcd -
		else
			mkview
		endif
	catch /\<E186\>/
	catch /\<E190\>/
	endtry
endfunction
