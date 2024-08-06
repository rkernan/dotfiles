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
    components.shortmode,
    {
      condition = components.gitsigns.head.condition,
      components.space,
      components.gitsigns.head
    },
    components.space,
    components.cwd,
    components.space,
    components.recording_macro,
    components.fill,
    components.tabsummary,
    components.space,
    components.fileformat,
    components.space,
    components.fileencoding,
  },
}
