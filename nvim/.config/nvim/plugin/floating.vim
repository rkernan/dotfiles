if exists('g:loaded_floating')
	finish
endif
let g:loaded_floating = 1

function! floating#setup(width, height, pad_left, pad_bottom)
	let buf = nvim_create_buf(v:false, v:true)

	let opts = { 'relative': 'editor' }
	let opts.width = a:width > 0 ? a:width : (&columns - (a:pad_left * 2))
	let opts.height = a:height > 0 ? a:height : &lines
	let opts.col = a:pad_left
	let opts.row = &lines - opts.height - a:pad_bottom

	let win = call('nvim_open_win', [buf, v:true, opts])
	call nvim_win_set_option(win, 'signcolumn', 'no')
	call nvim_win_set_option(win, 'number', v:false)
	call nvim_win_set_option(win, 'relativenumber', v:false)
	call nvim_win_set_option(win, 'cursorline', v:false)
endfunction

function! floating#small()
	return floating#setup(120, 20, 3, 3)
endfunction

function! floating#full()
	" TODO 'height = &lines - 5' if tabline is on
	return floating#setup(120, &lines - 4, 3, 3)
endfunction
