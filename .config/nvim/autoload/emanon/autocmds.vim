let g:emanonColorColumnBufferNameBlacklist = []
let g:emanonColorColumnFileTypeBlacklist = ['command-t', 'diff', 'fugitiveblame', 'undotree', 'nerdtree']
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

function! s:get_spell_settings() abort
	return {
				\   'spell': &l:spell,
				\   'spellcapcheck': &l:spellcapcheck,
				\   'spellfile': &l:spellfile,
				\   'spelllang': &l:spelllang
				\ }
endfunction

function! s:set_spell_settings(settings) abort
	let &l:spell=a:settings.spell
	let &l:spellcapcheck=a:settings.spellcapcheck
	let &l:spellfile=a:settings.spellfile
	let &l:spelllang=a:settings.spelllang
endfunction

function! emanon#autocmds#blur_window() abort
	if emanon#autocmds#should_colorcolumn()
		let l:settings=s:get_spell_settings()
		ownsyntax off
		set nolist
		if has('conceal')
			set conceallevel=0
		endif
		call s:set_spell_settings(l:settings)
	endif
endfunction

function! emanon#autocmds#focus_window() abort
	if emanon#autocmds#should_colorcolumn()
		if !empty(&ft)
			let l:settings=s:get_spell_settings()
			ownsyntax on
			set list
			if has('conceal')
				set conceallevel=1
			endif
			call s:set_spell_settings(l:settings)
		endif
	endif
endfunction

function! emanon#autocmds#blur_statusline() abort
	let l:blurred='%{emanon#statusline#gutterpadding()}'
	let l:blurred.='\ '
	let l:blurred.='\ '
	let l:blurred.='\ '
	let l:blurred.='\ '
	let l:blurred.='%<'
	let l:blurred.='%f'
	let l:blurred.='%='
	call s:update_statusline(l:blurred, 'blur')
endfunction

function! emanon#autocmds#focus_statusline() abort
	call s:update_statusline('', 'focus')
endfunction

function! s:update_statusline(default, action) abort
	let l:statusline = s:get_custom_statusline(a:action)
	if type(l:statusline) == type('')
		execute 'setlocal statusline=' . l:statusline
	elseif l:statusline == 0
		return
	else
		execute 'setlocal statusline=' . a:default
	endif
endfunction

function! s:get_custom_statusline(action) abort
	if &ft ==# 'command-t'
		return '\ \ ' . substitute(bufname('%'), ' ', '\\ ', 'g')
	elseif &ft ==# 'diff' && exists('t:diffpanel') && t:diffpanel.bufname ==# bufname('%')
		return 'Undotree\ preview'
	elseif &ft ==# 'undotree'
		return 0
	elseif &ft ==# 'nerdtree'
		return 0
	endif

	return 1
endfunction

function! emanon#autocmds#idleboot() abort
	augroup emanonIdleboot
		autocmd!
	augroup END

	doautocmd User emanonDefer
	autocmd! User emanonDefer
endfunction
