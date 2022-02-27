vim.api.nvim_set_keymap('n', '<leader><leader>a', ':<C-u>CocFzfList actions<CR>',
                        { noremap = true, nowait = true })
vim.api.nvim_set_keymap('n', '<leader><leader>b', ':<C-u>CocFzfList diagnostics --current-buf<CR>',
                        { noremap = true, nowait = true })
vim.api.nvim_set_keymap('n', '<leader><leader>c', ':<C-u>CocFzfList commands<CR>',
                        { noremap = true, nowait = true })
vim.api.nvim_set_keymap('n', '<leader><leader>l', ':<C-u>CocFzfList location<CR>',
                        { noremap = true, nowait = true })
vim.api.nvim_set_keymap('n', '<leader><leader>o', ':<C-u>CocFzfList outline<CR>',
                        { noremap = true, nowait = true })
vim.api.nvim_set_keymap('n', '<leader><leader>s', ':<C-u>CocFzfList symbols<CR>',
                        { noremap = true, nowait = true })
vim.api.nvim_set_keymap('n', '<leader><leader>S', ':<C-u>CocFzfList services',
                        { noremap = true, nowait = true })
