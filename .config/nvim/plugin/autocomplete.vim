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

let g:UltiSnipsSnippetDirectories = ['ultisnips']

call deoplete#enable()
call deoplete#custom#source('file', 'rank', 2000)
call deoplete#custom#source('ultisnips', 'rank', 1000)
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
