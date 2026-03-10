local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = '󰔶',
  [vim.diagnostic.severity.WARN]  = '󰔶',
  [vim.diagnostic.severity.INFO]  = '󰝤',
  [vim.diagnostic.severity.HINT]  = '󰝤',
}

---Set up auto-command to update loclist on DiagnosticChanged
function M.setup_auto_loclist()
  local augroup = vim.api.nvim_create_augroup('rkernan.diagnostic', { clear = true })
  vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = augroup,
    callback = function ()
      vim.diagnostic.setloclist({ open = false })
    end,
  })
end

return M
