" Normal mode mappings.

"Move cursor by display lines
nnoremap j gj
nnoremap k gk

" Toggle fold at current position.
nnoremap <Tab> za

" Avoid unintentional switches to Ev mode.
nnoremap Q <nop>

" Multi-mode mappings (Normal, Visual, Operating-pending modes).
noremap Y y$

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Repurpose cursor keys (accessible near homerow via "SpaceFN" layout) for one
" of my most oft-use key sequences.
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

nnoremap <silent> <S-Up> :lprevious<CR>
nnoremap <silent> <S-Down> :lnext<CR>
nnoremap <silent> <S-Left> :lpfile<CR>
nnoremap <silent> <S-Right> :lnfile<CR>

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <evpr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <evpr> j (v:count > 5 ? "m'" . v:count : '') . 'j'
