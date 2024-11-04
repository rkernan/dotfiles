local M = {}

local utils = require('rkernan.plugins.heirline.utils')

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
  condition = function ()
    return vim.g.git_head
  end,
  provider = function (self)
    return string.format('%s %s', self.icon, vim.g.git_head)
  end,
  hl = { fg = 'git_head' },
}

return M
