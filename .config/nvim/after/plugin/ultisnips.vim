let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

let g:UltiSnipsMappingsToIgnore = ['autocomplete']
let g:UltiSnipsSnippetDirectories = ['ultisnips']

inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

if exists(':UltiSnipsEdit')
	execute 'inoremap <silent> ' . g:UltiSnipsExpandTrigger .
				\ ' <C-R>=autocomplete#expand_or_jump("N")<CR>'
	execute 'snoremap <silent> ' . g:UltiSnipsExpandTrigger .
				\ ' <Esc>:call autocomplete#expand_or_jump("N")<CR>'
endif

if has('autocmd')
	augroup Autocomplete
		autocmd!
		autocmd! User UltiSnipsEnterFirstSnippet
		autocmd User UltiSnipsEnterFirstSnippet call autocomplete#setup_mappings()
		autocmd! User UltiSnipsExitLastSnippet
		autocmd User UltiSnipsExitLastSnippet call autocomplete#teardown_mappings()
	augroup END
endif
