function! s:num_buffers()
	return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

function! s:loclist_toggle()
	let prev_num_buffers = s:num_buffers()
	lclose
	if prev_num_buffers == s:num_buffers()
		try
			lopen
			wincmd p
		catch
			echo 'loclist empty'
		endtry
	endif
endfunction

function! s:quickfix_toggle()
	let prev_num_buffers = s:num_buffers()
	cclose
	if prev_num_buffers == s:num_buffers()
		copen
		wincmd p
	endif
endfunction

nmap <silent> <leader>l :call <SID>loclist_toggle()<cr>
nmap <silent> <leader>q :call <SID>quickfix_toggle()<cr>
