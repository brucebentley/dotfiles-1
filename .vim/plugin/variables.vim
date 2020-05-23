scriptencoding uft-8

let g:emanonQuickfixStatusline =
			\ '%7*'
			\ . '%{emanon#statusline#lhs()}'
			\ . '%*'
			\ . '%4*'
			\ . ''
			\ . '\ '
			\ . '%*'
			\ . '%3*'
			\ . '%q'
			\ . '\ '
			\ . '%{get(w:,\"quickfix_title\",\"\")}'
			\ . '%*'
			\ . '%<'
			\ . '\ '
			\ . '%='
			\ . '\ '
			\ . ''
			\ . '%5*'
			\ . '%{emanon#statusline#rhs()}'
			\ . '%*'

call emanon#defer#defer('call emanon#variables#init()')
