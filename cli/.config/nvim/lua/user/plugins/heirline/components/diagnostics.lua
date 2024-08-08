local conditions = require('heirline.conditions')
local diagnostic_signs = require('user.diagnostics').signs

return {
  condition = conditions.has_diagnostics,
  static = {
    icons = {
      error = diagnostic_signs[vim.diagnostic.severity.ERROR],
      warn  = diagnostic_signs[vim.diagnostic.severity.WARN],
      info  = diagnostic_signs[vim.diagnostic.severity.INFO],
      hint  = diagnostic_signs[vim.diagnostic.severity.HINT],
    },
  },
  init = function (self)
    self.count = {
      error = 0,
      warn = 0,
      hint = 0,
      info = 0,
      -- error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
      -- warn  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
      -- hint  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }),
      -- info  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }),
    }
  end,
  -- update = { 'DiagnosticChanged', 'BufEnter' },
  {
    {
      -- errors
      provider = function (self)
        return self.count.error > 0 and string.format('%s %d ', self.icons.error, self.count.error)
      end,
      on_click = {
        callback = function (self, minwid, nclicks, buttons, mods)
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        name = 'heirline_diagnostics_error',
      },
      hl = { fg = 'diagnostics_error' },
    }, {
      -- warnings
      provider = function (self)
        return self.count.warn > 0 and string.format('%s %d ', self.icons.warn, self.count.warn)
      end,
      on_click = {
        callback = function (self, minwid, nclicks, buttons, mods)
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
        end,
        name = 'heirline_diagnostics_warn',
      },
      hl = { fg = 'diagnostics_warn' },
    }, {
      -- info
      provider = function (self)
        return self.count.info > 0 and string.format('%s %d ', self.icons.info, self.count.info)
      end,
      on_click = {
        callback = function (self, minwid, nclicks, buttons, mods)
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.INFO })
        end,
        name = 'heirline_diagnostics_info',
      },
      hl = { fg = 'diagnostics_info' },
    }, {
      -- hints
      provider = function (self)
        return self.count.hint > 0 and string.format('%s %d ', self.icons.hint, self.count.hint)
      end,
      on_click = {
        callback = function (self, minwid, nclicks, buttons, mods)
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })
        end,
        name = 'heirline_diagnostics_hint',
      },
      hl = { fg = 'diagnostics_hint' },
    }
  }
}
