function! s:SetUpLoupeHighlight()
	if !emanon#pinnacle#active()
		return
	endif

	execute 'highlight! QuickFixLine ' . pinnacle#extract_highlight('PmenuSel')

	highlight! clear Search
	execute 'highlight! Search ' . pinnacle#embolden('Underlined')
endfunction

if has('autocmd')
	augroup emanonLoupe
		autocmd!
		autocmd ColorScheme * call s:SetUpLoupeHighlight()
	augroup END
endif
