local M = {}

function M.setup()
  vim.g.tmux_navigator_no_mappings = 1
  vim.g.tmux_navigator_disable_when_zoomed = 1
end

function M.config()
  vim.api.nvim_set_keymap('n', '<m-h>',  '<cmd>TmuxNavigateLeft<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<m-j>',  '<cmd>TmuxNavigateDown<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<m-k>',  '<cmd>TmuxNavigateUp<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<m-l>',  '<cmd>TmuxNavigateRight<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<m-\\>', '<cmd>TmuxNavigatePrevious<cr>', { noremap = true })
end

return M
