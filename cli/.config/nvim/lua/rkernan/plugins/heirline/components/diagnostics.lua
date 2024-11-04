local M = {}

local diagnostic_signs = require('rkernan.diagnostics').signs
local utils = require('rkernan.plugins.heirline.utils')

M.error = {
  static = {
    icon = diagnostic_signs[vim.diagnostic.severity.ERROR],
  },
  on_click = {
    callback = function (...)
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end,
    name = 'heirline_diagnostics_error',
  },
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('DiagnosticChanged', { callback = function () utils.reset_win_cache(self) end })
      self.once = true
    end
  end,
  condition = function ()
    return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) > 0
  end,
  provider = function (self)
    return string.format('%s %s', self.icon, #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }))
  end,
  hl = { fg = 'diagnostics_error' },
}

M.warn = {
  static = {
    icon = diagnostic_signs[vim.diagnostic.severity.WARN],
  },
  on_click = {
    callback = function (...)
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
    end,
    name = 'heirline_diagnostics_warn',
  },
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('DiagnosticChanged', { callback = function () utils.reset_win_cache(self) end })
      self.once = true
    end
  end,
  condition = function ()
    return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }) > 0
  end,
  provider = function (self)
    return string.format('%s %s', self.icon, #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }))
  end,
  hl = { fg = 'diagnostics_warn' },
}

M.info = {
  static = {
    icon = diagnostic_signs[vim.diagnostic.severity.INFO],
  },
  on_click = {
    callback = function (...)
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.INFO })
    end,
    name = 'heirline_diagnostics_info',
  },
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('DiagnosticChanged', { callback = function () utils.reset_win_cache(self) end })
      self.once = true
    end
  end,
  condition = function ()
    return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }) > 0
  end,
  provider = function (self)
    return string.format('%s %s', self.icon, #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }) > 0)
  end,
  hl = { fg = 'diagnostics_info' },
}

M.hint = {
  static = {
    icon = diagnostic_signs[vim.diagnostic.severity.HINT],
  },
  on_click = {
    callback = function (...)
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })
    end,
    name = 'heirline_diagnostics_hint',
  },
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('DiagnosticChanged', { callback = function () utils.reset_win_cache(self) end })
      self.once = true
    end
  end,
  condition = function ()
    return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }) > 0
  end,
  provider = function (self)
    return string.format('%s %s', self.icon, #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }) > 0)
  end,
  hl = { fg = 'diagnostics_hint' },

}

return M
