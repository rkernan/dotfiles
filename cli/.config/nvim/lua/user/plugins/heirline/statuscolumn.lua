local components = require('user.plugins.heirline.components')
local conditions = require('heirline.conditions')

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
    components.statuscolumn.signs,
    components.statuscolumn.line_number,
    components.statuscolumn.folds,
    -- TODO gitsigns closest to code
  }
}
