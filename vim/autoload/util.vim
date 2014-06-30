function! util#path_join(...)
	if a:0 > 0
		return join(a:000, '/')
	endif
	return ''
endfunction

function! util#mkdir_if_none(dir)
	if !isdirectory(expand(a:dir))
		if exists('*mkdir')
			call mkdir(expand(a:dir), 'p')
			echo 'created directory: ' . a:dir
		else
			echo 'cannot make directory: ' . a:dir
		endif
	endif
endfunction
