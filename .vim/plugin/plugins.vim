call emanon#defer#defer('call emanon#plugins#abolish()')

call emanon#plugin#lazy({
      \   'pack': 'undotree',
      \   'plugin': 'undotree.vim',
      \   'nnoremap': {
      \     '<silent> <Leader>u': ':UndotreeToggle<CR>'
      \   },
      \   'beforeload': [
      \     'call emanon#undotree#init()',
      \   ]
\ })
