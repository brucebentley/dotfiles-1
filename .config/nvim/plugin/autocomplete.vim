let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

let g:UltiSnipsMappingsToIgnore = ['autocomplete']
let g:UltiSnipsSnippetDirectories = ['ultisnips']

if has('autocmd')
	augroup EmanonAutocomplete
		autocmd!
		autocmd! User UltiSnipsEnterFirstSnippet
		autocmd User UltiSnipsEnterFirstSnippet call emanon#autocomplete#setup_mappings()
		autocmd! User UltiSnipsExitLastSnippet
		autocmd User UltiSnipsExitLastSnippet call emanon#autocomplete#teardown_mappings()
	augroup END
endif

autocmd User EmanonDefer call emanon#autocomplete#deoplete_init()
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : ''
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : ''
