return {
  signs = {
    [vim.diagnostic.severity.ERROR] = '󰔶',
    [vim.diagnostic.severity.WARN] = '󰔶',
    [vim.diagnostic.severity.INFO] = '󰝤',
    [vim.diagnostic.severity.HINT] = '󰝤',
  },
  sign_hl = {
    [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
  }
}
