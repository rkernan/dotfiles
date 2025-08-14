local diagnostic_signs = require('rkernan.diagnostics')
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
  signs = {
    text = diagnostic_signs.signs,
  },
  update_in_insert = true,
  float = {
    border = 'single',
    header = '',
    source = true,
    prefix = function (diagnostic)
      local sign = string.format('%s ', diagnostic_signs.signs[diagnostic.severity])
      local hl = diagnostic_signs.sign_hl[diagnostic.severity]
      return sign, hl
    end,
  },
})
