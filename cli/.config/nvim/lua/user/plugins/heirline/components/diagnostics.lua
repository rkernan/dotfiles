local conditions = require('heirline.conditions')

local diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    icons = {
      errors = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
      warnings = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
      hints = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
      info = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
    },
  },
  init = function (self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { 'DiagnosticChanged', 'Bufenter' },
  on_click = {
    callback = function (self, minwid, nclicks, buttons, mods)
      -- FIXME duplicate layout_strategy
      require('telescope.builtin').diagnostics({ layout_strategy = 'vertical', bufnr = 0 })
    end,
    name = 'heirline_diagnostics',
  }, {
    provider = function (self)
    return self.errors > 0 and (' ' .. self.icons.errors .. self.errors)
    end,
    hl = 'StatusLineDiagnosticError',
  }, {
    provider = function (self)
      return self.warnings > 0 and (' ' .. self.icons.warnings .. self.warnings)
    end,
    hl = 'StatusLineDiagnosticWarn',
  }, {
    provider = function (self)
      return self.hints > 0 and (' ' .. self.icons.hints .. self.hints)
    end,
    hl = 'StatusLineDiagnosticHint',
  }, {
    provider = function (self)
      return self.info > 0 and (' ' .. self.icons.info .. self.info)
    end,
    hl = 'StatusLineDiagnosticInfo',
  },
}

return diagnostics