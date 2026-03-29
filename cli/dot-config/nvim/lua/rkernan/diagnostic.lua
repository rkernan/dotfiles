local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = '󰔶',
  [vim.diagnostic.severity.WARN]  = '󰔶',
  [vim.diagnostic.severity.INFO]  = '󰝤',
  [vim.diagnostic.severity.HINT]  = '󰝤',
}

return M
