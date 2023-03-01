local M = {}

function M.local_diagnostics()
  require('telescope.builtin').diagnostics({ layout_strategy = 'vertical', bufnr = 0 })
end

function M.workspace_diagnostics()
  require('telescope.builtin').diagnostics({ layout_strategy = 'vertical' })
end

return M
