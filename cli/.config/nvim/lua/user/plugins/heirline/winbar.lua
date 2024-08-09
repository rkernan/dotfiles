local components = require('user.plugins.heirline.components')
local conditions = require('heirline.conditions')

local buftype_disable = { 'nofile', 'help', 'prompt', 'quickfix', 'terminal' }
local filetype_disable = {}

return {
  hl = function ()
    if conditions.is_active() then
      return 'StatusLine'
    else
      return 'StatusLineNC'
    end
  end,
  fallthrough = false,
  {
    condition = function ()
      return conditions.buffer_matches({
        buftype = buftype_disable,
        filetype = filetype_disable,
      })
    end,
    init = function ()
      vim.opt_local.winbar = nil
    end,
  }, {
    components.filename,
    components.space,
    components.gitsigns.added,
    components.gitsigns.changed,
    components.gitsigns.deleted,
    components.navic,
    components.fill,
    components.diagnostics,
    components.ruler,
  },
}
