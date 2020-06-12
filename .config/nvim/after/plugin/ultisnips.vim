if exists(':UltiSnipsEdit')
	execute 'inoremap <silent> ' . g:UltiSnipsExpandTrigger .
				\ ' <C-R>=autocomplete#expand_or_jump("N")<CR>'
	execute 'snoremap <silent> ' . g:UltiSnipsExpandTrigger .
				\ ' <Esc>:call autocomplete#expand_or_jump("N")<CR>'
endif
