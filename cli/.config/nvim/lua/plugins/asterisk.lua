-- vim.g.asterisk['keeppos'] = true

vim.api.nvim_set_keymap('n', '*', '<Plug>(asterisk-z*)', {})
vim.api.nvim_set_keymap('v', '*', '<Plug>(asterisk-z*)', {})
vim.api.nvim_set_keymap('o', '*', '<Plug>(asterisk-z*)', {})

vim.api.nvim_set_keymap('n', '#', '<Plug>(asterisk-z#)', {})
vim.api.nvim_set_keymap('v', '#', '<Plug>(asterisk-z#)', {})
vim.api.nvim_set_keymap('o', '#', '<Plug>(asterisk-z#)', {})

vim.api.nvim_set_keymap('n', 'g*', '<Plug>(asterisk-gz*)', {})
vim.api.nvim_set_keymap('v', 'g*', '<Plug>(asterisk-gz*)', {})
vim.api.nvim_set_keymap('o', 'g*', '<Plug>(asterisk-gz*)', {})

vim.api.nvim_set_keymap('n', 'g#', '<Plug>(asterisk-gz#)', {})
vim.api.nvim_set_keymap('v', 'g#', '<Plug>(asterisk-gz#)', {})
vim.api.nvim_set_keymap('o', 'g#', '<Plug>(asterisk-gz#)', {})
