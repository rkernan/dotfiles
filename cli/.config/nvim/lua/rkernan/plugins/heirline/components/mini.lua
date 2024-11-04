local M = {}

local utils = require('rkernan.plugins.heirline.utils')

local diff_shared = {
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('User', { pattern = 'MiniDiffUpdated', callback = function () utils.reset_win_cache(self) end })
      self.once = true
    end
  end,
}

M.diff = {
  add = vim.tbl_extend('force', diff_shared, {
    static = {
      icon = '+',
    },
    condition = function ()
      return vim.b.minidiff_summary and (vim.b.minidiff_summary.add or 0) > 0
    end,
    provider = function (self)
      return string.format('%s%d', self.icon, vim.b.minidiff_summary.add)
    end,
    hl = { fg = 'minidiff_add' },
  }),
  change = vim.tbl_extend('force', diff_shared, {
    static = {
      icon = '~',
    },
    condition = function ()
      return vim.b.minidiff_summary and (vim.b.minidiff_summary.change or 0) > 0
    end,
    provider = function (self)
      return string.format('%s%d', self.icon, vim.b.minidiff_summary.change)
    end,
    hl = { fg = 'minidiff_change' },
  }),
  delete = vim.tbl_extend('force', diff_shared, {
    static = {
      icon = '-',
    },
    condition = function ()
      return vim.b.minidiff_summary and (vim.b.minidiff_summary.delete or 0) > 0
    end,
    provider = function (self)
      return string.format('%s%d', self.icon, vim.b.minidiff_summary.delete)
    end,
    hl = { fg = 'minidiff_delete' },
  }),
}

return M
