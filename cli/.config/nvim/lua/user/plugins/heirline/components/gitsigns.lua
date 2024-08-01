local M = {}


local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local gitsigns = {
  condition = conditions.is_git_repo,
  init = function (self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,
}

M.head = utils.insert(gitsigns, {
  static = {
    icon = ''
  },
  provider = function (self)
    return string.format('%s %s', self.icon, self.status_dict.head)
  end,
  hl = { fg = 'gitsigns_head' },
})

M.added = utils.insert(gitsigns, {
  static = {
    icon = '+',
  },
  condition = function (self)
     return conditions.is_git_repo() and (self.status_dict.added or 0) > 0
  end,
  provider = function (self)
    local count = self.status_dict.added or 0
    return count > 0 and string.format('%s%d ', self.icon, count)
  end,
  hl = { fg = 'gitsigns_added' },
})

M.changed = utils.insert(gitsigns, {
  static = {
    icon = '~',
  },
  condition = function (self)
     return conditions.is_git_repo() and (self.status_dict.changed or 0) > 0
  end,
  provider = function (self)
    local count = self.status_dict.changed or 0
    return count > 0 and string.format('%s%d ', self.icon, count)
  end,
  hl = { fg = 'gitsigns_changed' },
})

M.deleted = utils.insert(gitsigns, {
  static = {
    icon = '-',
  },
  condition = function (self)
     return conditions.is_git_repo() and (self.status_dict.removed or 0) > 0
  end,
  provider = function (self)
    local count = self.status_dict.removed or 0
    return count > 0 and string.format('%s%d ', self.icon, count)
  end,
  hl = { fg = 'gitsigns_deleted' },
})

return M
