local M = {}

local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local git = {
  condition = conditions.is_git_repo,
  init = function (self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,
}

local head = {
  static = {
    icon = ' '
  },
  provider = function (self)
    return ' ' .. self.icon .. self.status_dict.head
  end,
  hl = { fg = 'magenta' },
}

M.head = utils.insert(git, head)

local diff = {
  static = {
    icons = {
      added = '+',
      deleted = '-',
      changed = '~',
    }
  }, {
    provider = function (self)
      local count = self.status_dict.added or 0
      return count > 0 and (' ' .. self.icons.added .. count)
    end,
    hl = { fg = 'git_add' },
  }, {
    provider = function (self)
      local count = self.status_dict.changed or 0
      return count > 0 and (' ' .. self.icons.changed .. count)
    end,
    hl = { fg = 'git_change' },
  }, {
    provider = function (self)
      local count = self.status_dict.removed or 0
      return count > 0 and (' ' .. self.icons.deleted .. count)
    end,
    hl = { fg = 'git_del' },
  }
}

M.diff = utils.insert(git, diff)

return M
