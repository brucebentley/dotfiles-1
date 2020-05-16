function! emanon#git#get_git_dir(file) abort
    let l:path=fnamemodify(a:file, ':p')
    while 1
        let l:path=fnamemodify(l:path, ':h')
        let l:candidate=l:path . '/.git'
        if isdirectory(l:candidate)
            return l:candidate
        endif
        if l:path == '' || l:path == '/'
            return ''
        endif
    endwhile
endfunction
