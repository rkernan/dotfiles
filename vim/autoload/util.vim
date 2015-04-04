function! util#path_join(...)
	if a:0 > 0
		return join(a:000, '/')
	endif
	return ''
endfunction

function! util#mkdir_if_none(dir)
	if !isdirectory(expand(a:dir))
		if has('win32')
			silent call system('mkdir ' . a:dir)
		else
			silent call system('mkdir -p ' . a:dir)
		endif
		echo 'created directory: ' . a:dir
	endif
endfunction
