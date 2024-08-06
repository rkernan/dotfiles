local M = {}

local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local diagnostics = {
  condition = conditions.has_diagnostics,
  init = function (self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { 'DiagnosticChanged', 'BufEnter' },
}

M.errors = utils.insert(diagnostics, {
  static = {
    icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
  },
  provider = function (self)
    return self.errors > 0 and string.format('%s%d ', self.icon, self.errors)
  end,
  on_click = {
    callback = function (self, minwid, nclicks, buttons, mods)
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end,
    name = 'heirline_diagnostics_error',
  },
  hl = { fg = 'diagnostics_error' },
})

M.warnings = utils.insert(diagnostics, {
  static = {
    icon = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
  },
  provider = function (self)
    return self.warnings > 0 and string.format('%s%d ', self.icon, self.warnings)
  end,
  on_click = {
    callback = function (self, minwid, nclicks, buttons, mods)
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
    end,
    name = 'heirline_diagnostics_warn',
  },
  hl = { fg = 'diagnostics_warn' },
})

M.info = utils.insert(diagnostics, {
  static = {
    icon = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
  },
  provider = function (self)
    return self.info > 0 and string.format('%s%d ', self.icon, self.info)
  end,
  on_click = {
    callback = function (self, minwid, nclicks, buttons, mods)
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.INFO })
    end,
    name = 'heirline_diagnostics_info',
  },
  hl = { fg = 'diagnostics_info' },
})

M.hints = utils.insert(diagnostics, {
  static = {
    icon = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
  },
  provider = function (self)
    return self.hints > 0 and string.format('%s%d ', self.icon, self.hints)
  end,
  on_click = {
    callback = function (self, minwid, nclicks, buttons, mods)
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })
    end,
    name = 'heirline_diagnostics_hint',
  },
  hl = { fg = 'diagnostics_hint' },
})

return M
