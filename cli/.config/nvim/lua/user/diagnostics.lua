vim.fn.sign_define('DiagnosticSignError', { text = '󰔶', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '󰔶', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '󰝤', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '󰝤', texthl = 'DiagnosticSignHint' })

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  virtual_text = {
    prefix = function (message)
      if message.severity == vim.diagnostic.severity.ERROR then
        return vim.fn.sign_getdefined('DiagnosticSignError')[1].text
      elseif message.severity == vim.diagnostic.severity.WARN then
        return vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text
      elseif message.severity == vim.diagnostic.severity.INFO then
        return vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text
      else
        return vim.fn.sign_getdefined('DiagnosticSignHint')[1].text
      end
    end,
    spacing = 2,
    severity = { min = vim.diagnostic.severity.WARN },
  },
  float = {
    header = '',
    source = true,
    prefix = function (diagnostic, ...)
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        local sign = vim.fn.sign_getdefined('DiagnosticSignError')[1]
        return sign.text, sign.texthl
      elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        local sign = vim.fn.sign_getdefined('DiagnosticSignWarn')[1]
        return sign.text, sign.texthl
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        local sign = vim.fn.sign_getdefined('DiagnosticSignInfo')[1]
        return sign.text, sign.texthl
      else
        local sign = vim.fn.sign_getdefined('DiagnosticSignHint')[1]
        return sign.text, sign.texthl
      end
    end,
    border = 'single',
  },
})

vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnostic forward' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnostic backward' })
