let g:fzf_layout = { 'down': '~60%' }

let g:fzf_preview_window = 'right:60%'

command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, {'options': ['--preview', 'cat {}']}, <bang>0)

let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit'
			\ }

let g:fzf_colors = {
			\ 'fg':      ['fg', 'Normal'],
			\ 'bg':      ['bg', 'Normal'],
			\ 'hl':      ['fg', 'ModeMsg'],
			\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
			\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
			\ 'hl+':     ['fg', 'Type'],
			\ 'info':    ['fg', 'PreProc'],
			\ 'border':  ['fg', 'Ignore'],
			\ 'prompt':  ['fg', 'Conditional'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'marker':  ['fg', 'Keyword'],
			\ 'spinner': ['fg', 'Label'],
			\ 'header':  ['fg', 'Comment']
			\ }

if has('autocmd')
	augroup Fzf
		autocmd! FileType fzf
		autocmd FileType fzf set laststatus=0 noshowmode noruler
					\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
	augroup END
endif
