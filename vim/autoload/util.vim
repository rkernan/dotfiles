function! util#path_join(...)
	if a:0 > 0
		return join(a:000, '/')
	endif
	return ''
endfunction

function! util#mkdir_if_none(dir)
	if !isdirectory(expand(a:dir))
		let cmd = 'mkdir -p '
		if has('win32')
			let cmd = 'mkdir '
		endif

		execute '!' . cmd . '"' . expand(a:dir) . '"'
	endif
endfunction
