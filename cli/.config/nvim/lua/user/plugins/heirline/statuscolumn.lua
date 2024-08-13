local components = require('user.plugins.heirline.components')
local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local buftype_disable = { 'nofile', 'help', 'prompt', 'quickfix', 'terminal' }
local filetype_disable = {}

return {
  fallthrough = false,
  {
    condition = function ()
      conditions.buffer_matches({
        buftype = buftype_disable,
        filetype = filetype_disable,
      })
    end,
    init = function ()
      vim.opt_local.statuscolumn = nil
    end,
  }, {
    condition = conditions.is_not_active,
    -- TODO separate gitsigns, diagnostics, and dap
    components.column.folds,
    utils.surround({ '%=', '' }, nil, components.column.lnum),
    utils.surround({ '%=', '' }, nil, components.column.signs),
  }, {
    -- TODO separate gitsigns, diagnostics, and dap
    components.column.folds,
    utils.surround({ '%=', '' }, nil, components.column.lnum),
    utils.surround({ '%=', '' }, nil, components.column.signs),
  }
}
