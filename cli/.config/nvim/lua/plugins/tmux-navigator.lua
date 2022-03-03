local M = {}

function M.setup()
  vim.g.tmux_navigator_no_mappings = 1
  vim.g.tmux_navigator_disable_when_zoomed = 1
end

function M.config()
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', '<M-h>',  '<cmd>TmuxNavigateLeft<CR>', opts)
  vim.api.nvim_set_keymap('n', '<M-j>',  '<cmd>TmuxNavigateDown<CR>', opts)
  vim.api.nvim_set_keymap('n', '<M-k>',  '<cmd>TmuxNavigateUp<CR>', opts)
  vim.api.nvim_set_keymap('n', '<M-l>',  '<cmd>TmuxNavigateRight<CR>', opts)
  vim.api.nvim_set_keymap('n', '<M-\\>', '<cmd>TmuxNavigatePrevious<CR>', opts)
end

return M
