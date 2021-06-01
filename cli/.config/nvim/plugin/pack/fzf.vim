nnoremap <nowait> <leader>b :Buffers<cr>
nnoremap <nowait> <leader>f :Files<cr>
nnoremap <nowait> <leader>/ :Rg<cr>
" split with C-s instead of C-x
let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }
" floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
