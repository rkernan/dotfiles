vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', { noremap = true, nowait = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', { noremap = true, nowait = true })
vim.api.nvim_set_keymap('n', '<leader>/', ':Rg<CR>', { noremap = true, nowait = true })
-- split with C-s instead of C-x
vim.g.fzf_action = { ['ctrl-t'] = 'tab split', ['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit' }
-- floating window
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
