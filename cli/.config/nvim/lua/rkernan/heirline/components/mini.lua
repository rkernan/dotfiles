local M = {}

local utils = require('heirline.utils')
local myutils = require('rkernan.heirline.utils')

local diff_shared = {
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('User', { pattern = 'MiniDiffUpdated', callback = function () myutils.reset_win_cache(self) end })
      self.once = true
    end
    self.count = self.get_count()
  end,
  -- FIXME condition is not re-evaluated on events
  -- condition = function (self)
  --   return self.count > 0
  -- end,
  flexible = 5,
  {
    provider = function (self)
      if self.count and self.count > 0 then
        return string.format('%s%d ', self.icon, self.count)
      end
    end
  }, {
    provider = '',
  },
}

M.diff = {}

M.diff.add = utils.insert({
  static = {
    icon = '+',
    get_count = function ()
      return vim.b.minidiff_summary and rawget(vim.b.minidiff_summary, 'add')
    end,
  },
  hl = { fg = 'minidiff_add' },
}, diff_shared)

M.diff.change = utils.insert({
  static = {
    icon = '~',
    get_count = function ()
      return vim.b.minidiff_summary and rawget(vim.b.minidiff_summary, 'change')
    end
  },
  hl = { fg = 'minidiff_change' },
}, diff_shared)

M.diff.delete = utils.insert({
  static = {
    icon = '-',
    get_count = function ()
      return vim.b.minidiff_summary and rawget(vim.b.minidiff_summary, 'delete')
    end,
  },
  hl = { fg = 'minidiff_delete' },
}, diff_shared)

return M
