local M = {}

-- TODO click handlers
-- TODO helper utility to show specific extmark signs

M.lnum = { provider = '%=%{v:lnum} ' }
M.relnum = { provider = '%=%{v:relnum} ' }
M.signs = { provider = '%s' }

M.folds = {
  fallthrough = false,
  init = function (self)
    self.foldlevel = vim.fn.foldlevel(vim.v.lnum)
    self.foldlevel_before = vim.fn.foldlevel((vim.v.lnum > 1) and (vim.v.lnum - 1) or 1)
    local maxline = vim.fn.line('$')
    self.foldlevel_after = vim.fn.foldlevel((vim.v.lnum < maxline) and (vim.v.lnum + 1 ) or maxline)
    self.foldclosed = vim.fn.foldclosed(vim.v.lnum)
  end,
  {
    condition = function (self)
      return self.foldlevel == 0
    end,
    provider = '  ',
  }, {
    condition = function (self)
      return self.foldclosed > 0 and self.foldclosed == vim.v.lnum
    end,
    provider = ' ',
  }, {
    condition = function (self)
      return self.foldlevel > self.foldlevel_before and self.foldlevel <= self.foldlevel_after
    end,
    provider = ' ',
  }, {
    condition = function (self)
      return self.foldlevel > self.foldlevel_after and self.foldlevel <= self.foldlevel_before
    end,
    provider = '╰ ',
  }, {
    provider = '│ ',
  },
  hl = 'FoldColumn',
}

return M
