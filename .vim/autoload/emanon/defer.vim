function! emanon#defer#defer(evalable) abort
    if has('autocmd') && has('vim_starting')
        execute 'autocmd User emanonDefer ' . a:evalable
    else
        execute a:evalable
    endif
endfunction

function! emanon#defer#packadd(pack, plugin) abort
    execute "call emanon#defer#defer('call emanon#plugin#packadd(\"' . a:pack . '\", \"' . a:plugin . '\")')"
endfunction
