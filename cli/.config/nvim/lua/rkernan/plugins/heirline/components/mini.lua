local M = {}

local diff_shared = {
  update = {
    'User',
    pattern = 'MiniDiffUpdated',
    callback = vim.schedule_wrap(function ()
      vim.cmd([[redrawstatus]])
    end)
  },
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
