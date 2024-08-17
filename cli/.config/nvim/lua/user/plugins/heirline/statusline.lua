local components = require('user.plugins.heirline.components')
local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

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
    components.space,
    utils.insert(components.gitsigns.head, components.space),
    utils.insert(components.virtualenv, components.space),
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
