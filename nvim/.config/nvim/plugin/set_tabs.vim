if exists('g:loaded_set_tabs')
	finish
endif
let g:loaded_set_tabs = 1

function! s:set_tabs()
	echohl Question
	let l:tabstop = 1 * input('setlocal tabstop = softtabstop = shiftwidth = ')
	let l:et = input('setlocal expandtab = (y/n)')
	echohl None
	if l:tabstop > 0
		let &l:ts = l:tabstop
		let &l:sts = l:tabstop
		let &l:sw = l:tabstop
	endif
	if l:et == "y"
		setlocal expandtab
	else
		setlocal noexpandtab
	end
	echo
	echo "\r"
	call s:summarize_tabs()
endfunction

function! s:summarize_tabs()
	try
		echomsg 'tabstop=' . &l:ts . ' softtabstop=' . &l:sts . ' shiftwidth=' . &l:sw . ' ' . ((&l:et) ? 'expandtab' : 'noexpandtab')
	endtry
endfunction

command! -nargs=0 SetTabs call s:set_tabs()
command! -nargs=0 SummarizeTabs call s:summarize_tabs()
