let b:did_after_plugin_ultisnips_after=1

if exists(':UltiSnipsEdit')
	execute 'inoremap <silent> ' . g:UltiSnipsExpandTrigger .
				\ ' <C-R>=emanon#autocomplete#expand_or_jump("N")<CR>'
	execute 'snoremap <silent> ' . g:UltiSnipsExpandTrigger .
				\ ' <Esc>:call emanon#autocomplete#expand_or_jump("N")<CR>'
	execute 'inoremap <silent> ' . g:UltiSnipsJumpBackwardTrigger .
				\ ' <C-R>=emanon#autocomplete#expand_or_jump("P")<CR>'
	execute 'snoremap <silent> ' . g:UltiSnipsJumpBackwardTrigger .
				\ ' <Esc>:call emanon#autocomplete#expand_or_jump("P")<CR>'
endif
