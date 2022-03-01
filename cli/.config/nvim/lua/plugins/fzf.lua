require('fzf-lua').setup({})

-- search files
vim.api.nvim_set_keymap('n', '<leader>b',
  [[ <cmd>lua require('fzf-lua').buffers()<cr> ]],
  { noremap = true })
-- search buffers
vim.api.nvim_set_keymap('n', '<leader>f',
  [[ <cmd>lua require('fzf-lua').files()<cr> ]],
  { noremap = true })
-- live grep project
vim.api.nvim_set_keymap('n', '<leader>/',
  [[ <cmd>lua require('fzf-lua').live_grep()<cr> ]],
  { noremap = true })

-- lsp code actions
vim.api.nvim_set_keymap('n', '<leader><leader>a',
  [[ <cmd>lua require('fzf-lua').lsp_code_actions()<cr> ]],
  { noremap = true })
-- lsp document diagnostics
vim.api.nvim_set_keymap('n', '<leader><leader>b',
  [[ <cmd>lua require('fzf-lua').lsp_document_diagnostics()<cr> ]],
  { noremap = true })
