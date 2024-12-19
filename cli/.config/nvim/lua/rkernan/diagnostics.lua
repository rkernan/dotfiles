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
    severity_sort = true,
    virtual_text = false,
    signs = {
      text = M.signs,
    },
    update_in_insert = true,
    float = {
      border = 'single',
      header = '',
      source = true,
      prefix = function (diagnostic)
        local sign = string.format('%s ', M.signs[diagnostic.severity])
        local hl = M.sign_hl[diagnostic.severity]
        return sign, hl
      end,
    },
  })

  vim.keymap.set('n', '<C-e>', function ()
    vim.diagnostic.open_float()
  end, { desc = 'Open diagnostic float' })
end

return M
