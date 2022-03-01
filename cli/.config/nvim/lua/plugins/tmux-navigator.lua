vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.api.nvim_set_keymap('n', '<M-h>',  [[ <cmd>TmuxNavigateLeft<CR> ]],     { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-j>',  [[ <cmd>TmuxNavigateDown<CR> ]],     { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-k>',  [[ <cmd>TmuxNavigateUp<CR> ]],       { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-l>',  [[ <cmd>TmuxNavigateRight<CR> ]],    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-\\>', [[ <cmd>TmuxNavigatePrevious<CR> ]], { noremap = true, silent = true })
