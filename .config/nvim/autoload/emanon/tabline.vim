function emanon#tabline#line() abort
	let l:line=''
	let l:current=tabpagenr()
	for l:i in range(1, tabpagenr('$'))
		if l:i == l:current
			let l:line.='%#TabLineSel#'
		else
			let l:line.='%#TabLine#'
		end
		let l:line.='%' . i . 'T'
		let l:line.=' %{emanon#tabline#label(' . i . ')} '
	endfor
	let l:line.='%#TabLineFill#'
	let l:line.='%T'
	return l:line
endfunction

function emanon#tabline#label(n) abort
	let l:buflist=tabpagebuflist(a:n)
	let l:winnr=tabpagewinnr(a:n)
	return pathshorten(fnamemodify(bufname(buflist[winnr - 1]), ':~:.'))
endfunction
