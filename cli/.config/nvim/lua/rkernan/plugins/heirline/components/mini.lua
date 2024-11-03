local M = {}

M.diff = {
  add = {
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
  },
  change = {
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
  },
  delete = {
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
  },
}

return M
