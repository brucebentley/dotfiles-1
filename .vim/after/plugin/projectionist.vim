let g:projectionist_heuristics = {
			\   '*': {
			\     '*.c': {
			\       'alternate': '{}.h',
			\       'type': 'source',
			\     },
			\     '*.h': {
			\       'alternate': '{}.c',
			\       'type': 'header'
			\     },
			\     '*.cpp': {
			\       'alternate': '{}.hpp',
			\       'type': 'source',
			\     },
			\     '*.hpp': {
			\       'alternate': '{}.cpp',
			\       'type': 'header'
			\     }
			\   }
			\ }

function! s:project(...)
	for [l:pattern, l:projection] in a:000
		let g:projectionist_heuristics['*'][l:pattern] = l:projection
	endfor
endfunction
