call emanon#plugin#lazy({
			\   'pack': 'undotree',
			\   'plugin': 'undotree.vim',
			\   'nnoremap': {
			\     '<silent> <Leader>u': ':UndotreeToggle<CR>'
			\   },
			\   'beforeload': [
			\     'let g:undotree_HighlightChangedText=0',
			\     'let g:undotree_SetFocusWhenToggle=1',
			\     'let g:undotree_WindowLayout=2',
			\     "let g:undotree_DiffCommand='diff -u'",
			\   ]
			\ })
