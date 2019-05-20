if exists('g:loaded_floating')
	finish
endif
let g:loaded_floating = 1

let g:floating_fzf_width = get(g:, 'float_fzf_width', 120)
let g:floating_fzf_height = get(g:, 'float_fzf_height', 20)
let g:floating_fzf_pad_side = get(g:, 'float_fzf_pad_side', 4)
let g:floating_fzf_pad_bottom = get(g:, 'float_fzf_pad_bottom', 3)

function! floating#open_fzf()
	let buf = nvim_create_buf(v:false, v:true)

	let opts = { 'relative': 'editor' }
	let opts.width = g:floating_fzf_width > 0 ? g:floating_fzf_width : (&columns - (g:floating_fzf_pad_side * 2))
	let opts.height = g:floating_fzf_height > 0 ? g:floating_fzf_height : &lines
	let opts.col = g:floating_fzf_pad_side
	let opts.row = &lines - opts.height - g:floating_fzf_pad_bottom

	let win = call('nvim_open_win', [buf, v:true, opts])
	call nvim_win_set_option(win, 'signcolumn', 'no')
	call nvim_win_set_option(win, 'number', v:false)
	call nvim_win_set_option(win, 'relativenumber', v:false)
	call nvim_win_set_option(win, 'cursorline', v:false)
endfunction
