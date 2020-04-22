let g:projectionist_heuristics = {
            \   '*': {
            \     '*.c': {
            \       'alternate': '{}.h',
            \       'type': 'source',
            \       'dispatch': 'gcc -g3 -Wall -Wextra -pipe {file}'
            \     },
            \     '*.h': {
            \       'alternate': '{}.c',
            \       'type': 'header'
            \     },
            \     '*.cpp': {
            \       'alternate': '{}.hpp',
            \       'type': 'source',
            \       'dispatch': 'g++ -g3 -Wall -Wextra -pipe {file}'
            \     },
            \     '*.hpp': {
            \       'alternate': '{}.cpp',
            \       'type': 'header'
            \     }
            \   }
            \ }

" Helper function for batch-updating the g:projectionist_heuristics variable.
function! s:project(...)
    for [l:pattern, l:projection] in a:000
        let g:projectionist_heuristics['*'][l:pattern] = l:projection
    endfor
endfunction
