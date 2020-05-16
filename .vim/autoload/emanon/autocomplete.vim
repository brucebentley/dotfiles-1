let s:expansion_active = 0

function! emanon#autocomplete#setup_mappings() abort
    execute 'inoremap <buffer> <silent> ' . g:UltiSnipsJumpForwardTrigger .
                \ ' <C-R>=emanon#autocomplete#expand_or_jump("N")<CR>'
    execute 'snoremap <buffer> <silent> ' . g:UltiSnipsJumpForwardTrigger .
                \ ' <Esc>:call emanon#autocomplete#expand_or_jump("N")<CR>'
    execute 'inoremap <buffer> <silent> ' . g:UltiSnipsJumpBackwardTrigger .
                \ ' <C-R>=emanon#autocomplete#expand_or_jump("P")<CR>'
    execute 'snoremap <buffer> <silent> ' . g:UltiSnipsJumpBackwardTrigger .
                \ ' <Esc>:call emanon#autocomplete#expand_or_jump("P")<CR>'

    imap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
    smap <expr> <buffer> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

    let s:expansion_active = 1
endfunction

function! emanon#autocomplete#teardown_mappings() abort
    silent! iunmap <expr> <buffer> <CR>
    silent! sunmap <expr> <buffer> <CR>

    let s:expansion_active = 0
endfunction

inoremap <expr> <BS> emanon#autocomplete#smart_bs()

let g:ulti_jump_backwards_res = 0
let g:ulti_jump_forwards_res = 0
let g:ulti_expand_res = 0

function! emanon#autocomplete#expand_or_jump(direction) abort
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            if a:direction ==# 'N'
                return "\<C-N>"
            else
                return "\<C-P>"
            endif
        else
            if s:expansion_active
                if a:direction ==# 'N'
                    call UltiSnips#JumpForwards()
                    if g:ulti_jump_forwards_res == 0
                        return "\<Tab>"
                    endif
                else
                    call UltiSnips#JumpBackwards()
                endif
            else
                if a:direction ==# 'N'
                    return emanon#autocomplete#smart_tab()
                endif
            endif
        endif
    endif

    return ''
endfunction

if exists('*shiftwidth')
    function! s:ShiftWidth()
        if &softtabstop <= 0
            return shiftwidth()
        else
            return &softtabstop
        endif
    endfunction
else
    function! s:ShiftWidth()
        if &softtabstop <= 0
            if &shiftwidth == 0
                return &tabstop
            else
                return &shiftwidth
            endif
        else
            return &softtabstop
        endif
    endfunction
endif

function! emanon#autocomplete#smart_tab() abort
    if &l:expandtab
        return "\<Tab>"
    else
        let l:prefix=strpart(getline('.'), 0, col('.') -1)
        if l:prefix =~# '^\s*$'
            return "\<Tab>"
        else
            let l:sw=s:ShiftWidth()
            let l:previous_char=matchstr(l:prefix, '.$')
            let l:previous_column=strlen(l:prefix) - strlen(l:previous_char) + 1
            let l:current_column=virtcol([line('.'), l:previous_column]) + 1
            let l:remainder=(l:current_column - 1) % l:sw
            let l:move=(l:remainder == 0 ? l:sw : l:sw - l:remainder)
            return repeat(' ', l:move)
        endif
    endif
endfunction

function! emanon#autocomplete#smart_bs() abort
    if &l:expandtab
        return "\<BS>"
    else
        let l:col=col('.')
        let l:prefix=strpart(getline('.'), 0, l:col - 1)
        if l:prefix =~# '^\s*$'
            return "\<BS>"
        endif
        let l:previous_char=matchstr(l:prefix, '.$')
        if l:previous_char !=# ' '
            return "\<BS>"
        else
            return "\<C-\>\<C-o>:set expandtab\<CR>" .
                        \ "\<C-\>\<C-o>:set noexpandtab\<CR>\<BS>"
        endif
    endif
endfunction

let s:deoplete_init_done=0
function! emanon#autocomplete#deoplete_init() abort
    if s:deoplete_init_done || !has('nvim')
        return
    endif
    let s:deoplete_init_done=1
    call deoplete#enable()
    call deoplete#custom#source('file', 'rank', 3000)
    call deoplete#custom#source('LanguageClient', 'rank', 1000)
    call deoplete#custom#source('ultisnips', 'rank', 2000)
    call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
endfunction
