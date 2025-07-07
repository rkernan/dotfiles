local M = {}

local utils = require('rkernan.heirline.utils')

M.head = {
  static = {
    icon = '',
  },
  init = function (self)
    if not rawget(self, 'once') then
      vim.api.nvim_create_autocmd('User', { pattern = 'GitHeadUpdate', callback = function () utils.reset_win_cache(self) end })
      self.once = true
    end
  end,
  -- FIXME condition is not re-evaluated on events
  -- condition = function ()
  --   return vim.g.git_head
  -- end,
  provider = function (self)
    if vim.g.git_head then
      return string.format('%s %s ', self.icon, vim.g.git_head)
    end
  end,
  hl = { fg = 'git_head' },
}

return M
