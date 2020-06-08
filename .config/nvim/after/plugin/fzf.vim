let g:fzf_layout = { 'down': '~60%' }

let g:fzf_preview_window = ''

let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit'
			\ }

let g:fzf_colors = {
			\ 'bg':      ['bg', 'Normal'],
			\ 'bg+':     ['bg', 'Ignore'],
			\ 'border':  ['fg', 'Ignore'],
			\ 'fg':      ['fg', 'Normal'],
			\ 'fg+':     ['fg', 'Type'],
			\ 'gutter':  ['bg', 'Ignore'],
			\ 'header':  ['fg', 'Comment'],
			\ 'hl':      ['fg', 'ModeMsg'],
			\ 'hl+':     ['fg', 'ModeMsg'],
			\ 'info':    ['fg', 'PreProc'],
			\ 'marker':  ['fg', 'Keyword'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'prompt':  ['fg', 'Directory'],
			\ 'spinner': ['fg', 'Label']
			\ }

if has('autocmd')
	augroup Fzf
		autocmd! FileType fzf
		autocmd FileType fzf set laststatus=0 noshowmode noruler norelativenumber
					\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler relativenumber
	augroup END
endif
