if exists('g:loaded_floating')
  finish
endif
let g:loaded_floating = 1

function! floating#setup(width, height, pad_left, pad_bottom, relative)
  " calculate the sign column width
  if &signcolumn == 'yes'
    let signwidth = 2
  elseif &signcolumn == 'auto'
    let signs = execute('sign place buffer=%d', bufnr(''))
    let signs = split(signs, '\n')
    let signwidth = len(signs) > 2 ? 2 : 0
  else
    let signwidth = 0
  endif

  " statusline height
  " FIXME laststatus == 1
  if &laststatus == 2
    let statusheight = 1
  else
    let statusheight = 0
  endif

  let buf = nvim_create_buf(v:false, v:true)

  let opts = { 'relative': a:relative }
  let opts.width = a:width > 0 ? a:width : (&columns - (a:pad_left * 2))
  let opts.height = a:height > 0 ? a:height : &lines
  let opts.col = a:pad_left + signwidth
  let opts.row = &lines - opts.height - a:pad_bottom - &cmdheight - statusheight

  let win = call('nvim_open_win', [buf, v:true, opts])
  call nvim_win_set_option(win, 'signcolumn', 'no')
  call nvim_win_set_option(win, 'number', v:false)
  call nvim_win_set_option(win, 'relativenumber', v:false)
  call nvim_win_set_option(win, 'cursorline', v:false)
endfunction

function! floating#small()
  return floating#setup(120, 20, 1, 1, 'editor')
endfunction

function! floating#full_win()
  return floating#setup(120, &lines - 4, 1, 1, 'win')
endfunction
