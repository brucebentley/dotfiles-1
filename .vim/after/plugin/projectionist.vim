let g:projectionist_heuristics = {
      \   '*': {
      \     '*.c': {
      \       'alternate': '{}.h',
      \       'type': 'source',
      \       'dispatch': 'gcc {file}'
      \     },
      \     '*.h': {
      \       'alternate': '{}.c',
      \       'type': 'header'
      \     },
      \     '*.cpp': {
      \       'alternate': '{}.hpp',
      \       'type': 'source',
      \       'dispatch': 'g++ {file}'
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

" Provide config for repos where I:
"
" - want special config
" - don't want to (or can't) commit a custom ".projections.json" file
" - can't set useful heuristics based on what's in the root directory
"
function! s:UpdateProjections()
  let l:cwd=getcwd()
  if l:cwd == expand('~/code/liferay-npm-tools')
    for l:pkg in glob('packages/*', 0, 1)
      call s:project(
            \ [l:pkg . '/src/*.js', {
            \   'alternate': l:pkg . '/test/{}.js',
            \   'type': 'source'
            \ }],
            \ [l:pkg . '/test/*.js', {
            \   'alternate': l:pkg . '/src/{}.js',
            \   'type': 'test'
            \ }])
    endfor
  endif
endfunction

call s:UpdateProjections()

if has('autocmd') && exists('#DirChanged')
  augroup WincentProjectionist
    autocmd!
    autocmd DirChanged * call <SID>UpdateProjections()
  augroup END
endif
