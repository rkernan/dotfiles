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
    components.statuscolumn.folds,
    components.statuscolumn.diagnostics,
    components.statuscolumn.lnum,
    components.statuscolumn.gitsigns,
  }, {
    components.statuscolumn.folds,
    components.statuscolumn.diagnostics,
    {
      fallthrough = false,
      utils.insert({
        condition = function ()
          return vim.fn.mode() == 'i' or vim.v.relnum == 0
        end,
      }, components.statuscolumn.lnum),
      {
        components.statuscolumn.relnum,
      }
    },
    components.statuscolumn.gitsigns,
  }
}
