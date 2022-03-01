vim.api.nvim_set_keymap('n', '<leader>b', [[ <cmd>lua require('fzf-lua').buffers()<CR> ]],   { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>f', [[ <cmd>lua require('fzf-lua').files()<CR> ]],     { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>/', [[ <cmd>lua require('fzf-lua').live_grep()<CR> ]], { noremap = true })

-- LSP
vim.api.nvim_set_keymap('n', '<leader><leader>a', [[ <cmd>lua require('fzf-lua').lsp_code_actions()<CR> ]],         { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><leader>b', [[ <cmd>lua require('fzf-lua').lsp_document_diagnostics()<CR> ]], { noremap = true })
