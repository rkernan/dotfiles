function! util#path_join(...)
	let separator = '/'
	if has('win32')
		let separator = '\'
	endif

	if a:0 > 0
		return join(a:000, separator)
	endif
	return ''
endfunction

function! util#mkdir_if_none(dir)
	if !isdirectory(expand(a:dir))
		let cmd = 'mkdir -p '
		if has('win32')
			let cmd = 'mkdir '
		endif

		call system(cmd . '"' . expand(a:dir) . '"')
	endif
endfunction
