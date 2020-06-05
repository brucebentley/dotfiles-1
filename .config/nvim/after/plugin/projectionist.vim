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
