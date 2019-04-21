if exists('g:loaded_float_fzf')
	finish
endif
let g:loaded_float_fzf = 1

let g:float_fzf_width = get(g:, 'float_fzf_width', 0)
let g:float_fzf_height = get(g:, 'float_fzf_height', 20)
let g:float_fzf_pad = get(g:, 'float_fzf_pad', 0)
let g:float_fzf_pad_left = get(g:, 'float_fzf_pad_left', g:float_fzf_pad)
let g:float_fzf_pad_right = get(g:, 'float_fzf_pad_right', g:float_fzf_pad)
let g:float_fzf_pad_bottom = get(g:, 'float_fzf_pad_bottom', g:float_fzf_pad)

function! float_fzf#open()
	let buf = nvim_create_buf(v:false, v:true)

	let opts = { 'relative': 'editor' }
	let opts.width = g:float_fzf_width > 0 ? g:float_fzf_width : &columns - g:float_fzf_pad_left - g:float_fzf_pad_right
	let opts.height = g:float_fzf_height > 0 ? g:float_fzf_height : &lines
	let opts.col = g:float_fzf_pad_left
	let opts.row = &lines - opts.height - g:float_fzf_pad_bottom

	let win = call('nvim_open_win', [buf, v:true, opts])
	call nvim_win_set_option(win, 'signcolumn', 'no')
	call nvim_win_set_option(win, 'number', v:false)
	call nvim_win_set_option(win, 'relativenumber', v:false)
	call nvim_win_set_option(win, 'cursorline', v:false)
endfunction
