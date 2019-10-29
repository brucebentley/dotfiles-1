" TODO: complete `find` arg names too
" TODO: check escaping is correct
command! -nargs=* -complete=file Find call emanon#commands#find(<q-args>)

command! -nargs=* -complete=file -range OpenOnGitHub <line1>,<line2>call emanon#commands#open_on_github(<f-args>)

command! Lint call emanon#commands#lint()

command! Typecheck call emanon#commands#typecheck()

command! Mvim call emanon#commands#mvim()

command! -nargs=* -complete=file Preview call emanon#commands#preview(<f-args>)
