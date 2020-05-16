scriptencoding utf-8

if has('statusline')
    set statusline=%7*
    set statusline+=%{emanon#statusline#lhs()}
    set statusline+=%*
    set statusline+=%4*
    set statusline+=
    set statusline+=%*
    set statusline+=\ 
    set statusline+=%<
    set statusline+=%{emanon#statusline#fileprefix()}
    set statusline+=%3*
    set statusline+=%t
    set statusline+=%*
    set statusline+=\ 
    set statusline+=%1*
    set statusline+=%([%R%{emanon#statusline#ft()}%{emanon#statusline#fenc()}]%)

    set statusline+=%*
    set statusline+=%=

    set statusline+=\ 
    set statusline+=
    set statusline+=%5*
    set statusline+=%{emanon#statusline#rhs()}
    set statusline+=%*

    if has('autocmd')
        augroup emanonStatusline
            autocmd!
            autocmd ColorScheme * call emanon#statusline#update_highlight()
            autocmd User FerretAsyncStart call emanon#statusline#async_start()
            autocmd User FerretAsyncFinish call emanon#statusline#async_finish()
            if exists('##TextChangedI')
                autocmd BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * call emanon#statusline#check_modified()
            else
                autocmd BufWinEnter,BufWritePost,FileWritePost,WinEnter * call emanon#statusline#check_modified()
            endif

            if has('statusline')
                autocmd BufEnter,FocusGained,VimEnter,WinEnter * call emanon#autocmds#focus_statusline()
                autocmd BufLeave,FocusLost,WinLeave * call emanon#autocmds#blur_statusline()
            endif
            autocmd BufEnter,FocusGained,VimEnter,WinEnter * call emanon#autocmds#focus_window()
            autocmd BufLeave,FocusLost,WinLeave * call emanon#autocmds#blur_window()
        augroup END
    endif
endif
