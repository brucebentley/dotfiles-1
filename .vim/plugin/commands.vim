command! -nargs=* -complete=file -range OpenOnGitHub <line1>,<line2>call emanon#commands#open_on_github(<f-args>)
