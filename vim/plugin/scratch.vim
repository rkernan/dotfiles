function! s:scratch_edit(options, cmd, height)
	silent execute a:height a:cmd
	setlocal buftype=nofile
	setlocal bufhidden=wipe
	setlocal nobuflisted
	if !empty(a:options)
		silent execute 'setlocal' a:options
	endif
endfunction

function! s:scratch_keep(file_name)
	if &buftype ==# 'nofile'
		setlocal buftype=
		setlocal bufhidden=
		setlocal buflisted
		silent execute 'file' a:file_name
		silent write
	endif
endfunction

command! -nargs=* Scratch call s:scratch_edit(<q-args>, 'new', 20)
command! -nargs=1 Keep call s:scratch_keep(<f-args>)
