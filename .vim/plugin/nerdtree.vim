"Show hidden files when open
let g:NERDTreeShowHidden=1

" Ignore turds left behind by Mercurial.
let g:NERDTreeIgnore=['\.orig']

" The default of 31 is just a little too narrow.
let g:NERDTreeWinSize=40

" Disable display of '?' text and 'Bookmarks' label.
let g:NERDTreeMinimalUI=1

" Let <Leader><Leader> (^#) return from NERDTree window.
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

"Close Nerdtree when a file is opened
let g:NERDTreeQuitOnOpen=1

"Sync delete files
let g:NERDTreeAutoDeleteBuffer=1

"Aethestic addition
let g:NERDTreeDirArrows=1

" Let <Leader><Leader> (^#) return from NERDTree window.
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

" Single-click to toggle directory nodes, double-click to open non-directory
" nodes.
let g:NERDTreeMouseMode=2

if has('autocmd')
    augroup emanonNERDTree
        autocmd!
        autocmd User NERDTreeInit call emanon#autocmds#attempt_select_last_file()
    augroup END
endif

" If any of the args are a directory, load NERDTree eagerly to prevent netrw
" from being used.
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
