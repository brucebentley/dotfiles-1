let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

let g:UltiSnipsMappingsToIgnore = ['autocomplete']

if has('autocmd')
	augroup emanonAutocomplete
		autocmd!
		autocmd! User UltiSnipsEnterFirstSnippet
		autocmd User UltiSnipsEnterFirstSnippet call emanon#autocomplete#setup_mappings()
		autocmd! User UltiSnipsExitLastSnippet
		autocmd User UltiSnipsExitLastSnippet call emanon#autocomplete#teardown_mappings()
	augroup END
endif

let g:UltiSnipsSnippetsDir = $HOME . '/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = [
			\ $HOME . '/.vim/ultisnips'
			\ ]

if has('nvim')
	packadd! deoplete.nvim
	call emanon#defer#defer('call emanon#autocomplete#deoplete_init()')

	inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
	inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
	inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
	inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
endif
