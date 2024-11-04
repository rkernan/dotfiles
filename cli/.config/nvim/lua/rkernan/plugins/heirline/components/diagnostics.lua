local M = {}

local utils = require('heirline.utils')
local diagnostic_signs = require('rkernan.diagnostics').signs
local myutils = require('rkernan.plugins.heirline.utils')

local diagnostics_shared = {
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('DiagnosticChanged', { callback = function () myutils.reset_win_cache(self) end })
      self.once = true
    end
    self.count = #vim.diagnostic.get(0, { severity = self.severity })
  end,
  -- FIXME condition is not re-evaluated on events
  -- condition = function (self)
  --   return self.count > 0
  -- end,
  flexible = 4,
  {
    provider = function (self)
      if self.count > 0 then
        return string.format('%s %s ', self.icon, self.count)
      end
    end,
  }, {
    provider = '',
  },
}

M.error = utils.insert({
  static = {
    icon = diagnostic_signs[vim.diagnostic.severity.ERROR],
    severity = vim.diagnostic.severity.ERROR,
  },
  on_click = {
    callback = function ()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end,
    name = 'heirline_diagnostics_error',
  },
  hl = { fg = 'diagnostics_error' },
}, diagnostics_shared)

M.warn = utils.insert({
  static = {
    icon = diagnostic_signs[vim.diagnostic.severity.WARN],
    severity = vim.diagnostic.severity.WARN,
  },
  on_click = {
    callback = function ()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
    end,
    name = 'heirline_diagnostics_warn',
  },
  hl = { fg = 'diagnostics_warn' },
}, diagnostics_shared)

M.info = utils.insert({
  static = {
    icon = diagnostic_signs[vim.diagnostic.severity.INFO],
    severity = vim.diagnostic.severity.INFO,
  },
  on_click = {
    callback = function ()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.INFO })
    end,
    name = 'heirline_diagnostics_info',
  },
  hl = { fg = 'diagnostics_info' },
}, diagnostics_shared)

M.hint = utils.insert({
  static = {
    icon = diagnostic_signs[vim.diagnostic.severity.HINT],
    severity = vim.diagnostic.severity.HINT,
  },
  on_click = {
    callback = function ()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })
    end,
    name = 'heirline_diagnostics_hint',
  },
  hl = { fg = 'diagnostics_hint' },
}, diagnostics_shared)

return M
