let g:NERDTreeShowHidden=1

let g:NERDTreeWinSize=40

let g:NERDTreeMinimalUI=1

let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

let g:NERDTreeQuitOnOpen=1

let g:NERDTreeAutoDeleteBuffer=1

let g:NERDTreeDirArrows=1

let g:NERDTreeMouseMode=2

if has('autocmd')
    augroup emanonNERDTree
        autocmd!
        autocmd User NERDTreeInit call emanon#autocmds#attempt_select_last_file()
    augroup END
endif

if len(filter(argv(), 'isdirectory(v:val)')) > 0
    call emanon#plugin#packadd('nerdtree', 'NERD_tree.vim')
    nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : fnameescape(expand('%:p:h'))<CR><CR>
    nnoremap <C-_> :NERDTreeFind<CR>
else
    call emanon#plugin#lazy({
                \   'pack': 'nerdtree',
                \   'plugin': 'NERD_tree.vim',
                \   'commands': {
                \     'NERDTree': '-n=? -complete=dir -bar',
                \     'NERDTreeCWD': '-n=0 -bar',
                \     'NERDTreeClose': '-n=0 -bar',
                \     'NERDTreeFind': '-n=0 -bar',
                \     'NERDTreeFocus': '-n=0 -bar',
                \     'NERDTreeFromBookmark': '-n=1 -bar',
                \     'NERDTreeMirror': '-n=0 -bar',
                \     'NERDTreeToggle': '-n=? -complete=dir -bar',
                \   },
                \   'nnoremap': {
                \     '<silent> -': ":silent edit <C-R>=empty(expand('%')) ? '.' : fnameescape(expand('%:p:h'))<CR><CR>",
                \     '<C-_>': ':NERDTreeFind<CR>'
                \   }
                \ })
endif
