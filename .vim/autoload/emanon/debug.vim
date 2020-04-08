function! emanon#debug#log(string) abort
  call writefile([a:string], '/tmp/vim-compiler-debug.txt', 'aS')
endfunction

function! emanon#debug#compiler() abort
  source %
  call setqflist([])
  /\v^finish>/+1,$ :cgetbuffer
  copen
endfunction
