local M = {}

M.head = {
  static = {
    icon = '',
  },
  condition = function ()
    return vim.g.git_head
  end,
  -- TODO
  provider = function (self)
    return string.format('%s %s', self.icon, vim.g.git_head)
  end,
  hl = { fg = 'git_head' },
  update = {
    'User',
    pattern = 'GitHeadUpdate',
    callback = vim.schedule_wrap(function ()
      vim.cmd([[redrawstatus]])
    end)
  },
}

return M
