function! emanon#undotree#init() abort
	let g:undotree_HighlightChangedText=0
	let g:undotree_SetFocusWhenToggle=1
	let g:undotree_WindowLayout=2
	let g:undotree_DiffCommand='diff -u'
endfunction

function! g:Undotree_CustomMap() abort
	nmap <buffer> j <Plug>UndotreeGoPreviousState
	nmap <buffer> k <Plug>UndotreeGoNextState

	nmap <buffer> <Return> <Plug>UndotreeClose
endfunction
