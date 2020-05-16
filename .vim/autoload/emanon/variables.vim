function! emanon#variables#init() abort
    let l:dirs=system(
                \ 'zsh -c "' .
                \ 'source ~/.zsh/config/hash.zsh; ' .
                \ 'hash -d"'
                \ )
    let l:lines=split(l:dirs, '\n')
    for l:line in l:lines
        let l:pair=split(l:line, '=')
        if len(l:pair) == 2
            let l:var=l:pair[0]
            let l:dir=l:pair[1]

            if !exists('$' . l:var)
                execute 'let $' . l:var . '="' . l:dir . '"'
            endif
        endif
    endfor
endfunction
