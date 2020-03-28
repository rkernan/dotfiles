if exists('g:loaded_after_colors')
  finish
endif
let g:loaded_after_colors = 1

function! s:after_colors()
  if exists('g:colors_name') && len(g:colors_name)
    execute 'runtime! after/colors/' . g:colors_name . '.vim'
  endif
endfunction

augroup after_colors
  autocmd!
  autocmd VimEnter * call <SID>after_colors()
  autocmd ColorScheme * call <SID>after_colors()
augroup END
