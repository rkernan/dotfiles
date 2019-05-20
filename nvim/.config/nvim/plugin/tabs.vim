if exists('g:loaded_tabs')
	finish
endif
let g:loaded_tabs = 1

function! tabs#set()
	echohl Question
	let l:tabstop = 1 * input('setlocal tabstop = softtabstop = shiftwidth = ')
	let l:et = input('setlocal expandtab [y/N] ')
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
	call tabs#summarize()
endfunction

function! tabs#summarize()
	try
		echomsg 'tabstop=' . &l:ts . ' softtabstop=' . &l:sts . ' shiftwidth=' . &l:sw . ' ' . ((&l:et) ? 'expandtab' : 'noexpandtab')
	endtry
endfunction

command! -nargs=0 SetTabs call tabs#set()
command! -nargs=0 SummarizeTabs call tabs#summarize()
