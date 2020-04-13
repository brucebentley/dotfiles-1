function! s:Config()
    " gd -- go to definition
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>

    " K -- lookup keyword
    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>

    if exists('+signcolumn')
        setlocal signcolumn=auto
    endif
endfunction

function! s:Bind()
    nnoremap <buffer> <silent> <Esc> :call LanguageClient#closeFloatingHover()<CR>
endfunction

augroup EmanonLanguageClientAutocmds
    autocmd!
    autocmd FileType * call s:Config()

    if has('nvim') && exists('*nvim_open_win')
        " Can use floating window.
        autocmd BufEnter __LanguageClient__ call s:Bind()
    endif
augroup END
