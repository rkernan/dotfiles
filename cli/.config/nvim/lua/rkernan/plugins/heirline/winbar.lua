local components = require('rkernan.plugins.heirline.components')
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
