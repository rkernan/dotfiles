local M = {}

M.signs = {
  [vim.diagnostic.severity.ERROR] = '󰔶',
  [vim.diagnostic.severity.WARN] = '󰔶',
  [vim.diagnostic.severity.INFO] = '󰝤',
  [vim.diagnostic.severity.HINT] = '󰝤',
}

M.sign_hl = {
  [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
  [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
  [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
  [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
}

function M.setup()
  vim.diagnostic.config({
    signs = {
      text = M.signs,
    },
    severity_sort = true,
    update_in_insert = false,
    virtual_text = {
      prefix = function (message)
        return M.signs[message.severity]
      end,
      spacing = 2,
      severity = { min = vim.diagnostic.severity.INFO },
    },
    float = {
      border = 'single',
      header = '',
      source = true,
      prefix= function (diagnostic, ...)
        local sign = string.format('%s ', M.signs[diagnostic.severity])
        local hl = M.sign_hl[diagnostic.severity]
        return sign, hl
      end,
    },
  })

  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnostic forward' })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnostic backward' })
end

return M
