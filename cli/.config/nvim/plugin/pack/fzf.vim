nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>/ :Rg<cr>
" split with C-s instead of C-x
let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }
" top-to-bottom
let $FZF_DEFAULT_OPTS='--layout=reverse'
" floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
