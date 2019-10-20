function! emanon#debug#log(string) abort
  call writefile([a:string], '/tmp/emanon-vim-debug.txt', 'aS')
endfunction

function! emanon#debug#compiler() abort
  " TODO: add check to confirm we're in .vim/after/cimpiler/*.vim or similar
  source %
  call setqflist([])
  /\v^finish>/+1,$ :cgetbuffer
  copen
endfunction
