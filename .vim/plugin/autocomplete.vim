if !exists("g:UltiSnipsJumpForwardTrigger")
    let g:UltiSnipsJumpForwardTrigger = '<Tab>'
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
endif

" Prevent UltiSnips from removing our carefully-crafted mappings.
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

" Additional UltiSnips config.
let g:UltiSnipsSnippetsDir = $HOME . '/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = [
            \ $HOME . '/.vim/ultisnips',
            \ $HOME . '/.vim/ultisnips-private'
            \ ]

if has('nvim')
    packadd! deoplete.nvim
    " Don't forget to run :UpdateRemotePlugins to populate
    " `~/.local/share/nvim/rplugin.vim`.
    call emanon#defer#defer('call emanon#autocomplete#deoplete_init()')

    inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
    inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
    inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
endif
