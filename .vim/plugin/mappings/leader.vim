" Leader mappings.

"   <Leader><Leader> -- Open last buffer.
nnoremap <Leader><Leader> <C-^>

nnoremap <Leader>w :write<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>x :quitall<CR>

"   <Leader>r -- Cycle through relativenumber + number, number (only), and no
"   numbering (mnemonic: relative).
nnoremap <silent> <Leader>r :call emanon#mappings#leader#cycle_numbering()<CR>

"   <Leader>zz -- Zap trailing whitespace in the current buffer.
"
"   As this one is somewhat destructive and relatively close to the
"   oft-used <leader>a mapping, make this one a double key-stroke.
nnoremap <silent> <Leader>zz :call emanon#mappings#leader#zap()<CR>

"   <LocalLeader>c -- Fix (most) syntax highlighting problems in current buffer
"   (mnemonic: coloring).
nnoremap <silent> <LocalLeader>c :syntax sync fromstart<CR>

"   <LocalLeader>d... -- Diff mode bindings:
"   <LocalLeader>dd: show diff view (mnemonic: [d]iff)
"   <LocalLeader>dh: choose hunk from left (mnemonic: [h] = left)
"   <LocalLeader>dl: choose hunk from right (mnemonic: [l] = right)
nnoremap <silent> <LocalLeader>dd :Gvdiff<CR>
nnoremap <silent> <LocalLeader>dh :diffget //2<CR>
nnoremap <silent> <LocalLeader>dl :diffget //3<CR>

"   <LocalLeader>e -- Edit file, starting in same directory as current file.
nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" (mnemonic: [m]atch paren)
nnoremap <silent> <Leader>m :call emanon#mappings#leader#matchparen()<CR>
