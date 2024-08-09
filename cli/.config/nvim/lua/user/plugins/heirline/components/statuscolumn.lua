local M = {}

local conditions = require('heirline.conditions')

-- TODO click handlers
-- TODO helper utility to show specific extmark signs

M.line_number = {
  provider = function (self)
    if not conditions.is_active() or vim.fn.mode() == 'i' then
      return '%{v:lnum}'
    else
      return '%{v:relnum}'
    end
  end
}

M.signs = { provider = '%s' }
M.folds = { provider = '%C' }

return M
