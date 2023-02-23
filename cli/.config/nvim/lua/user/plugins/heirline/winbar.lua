local components = require('user.plugins.heirline.components')
local conditions = require('heirline.conditions')

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
        buftype = { 'nofile', 'help', 'prompt', 'quickfix', 'terminal' }
      })
    end,
    init = function ()
      -- disable winbar
      vim.opt_local.winbar = nil
    end,
  }, {
    components.file.name,
    components.git.diff,
    components.navic,
    components.align,
    components.diagnostics,
    components.ruler,
  },
}
