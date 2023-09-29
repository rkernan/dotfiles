local M = {}

function M.local_diagnostics(opts)
  opts = vim.tbl_extend('force', opts or {}, { layout_strategy = 'vertical', bufnr = 0 })
  require('telescope.builtin').diagnostics(opts)
end

function M.workspace_diagnostics(opts)
  opts = vim.tbl_extend('force', opts or {}, { layout_strategy = 'vertical' })
  require('telescope.builtin').diagnostics(opts)
end

return M
