local components = require('rkernan.plugins.heirline.components')
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
    components.filename,
    components.space,
    utils.insert(components.mini.diff.add, components.space),
    utils.insert(components.mini.diff.change, components.space),
    utils.insert(components.mini.diff.delete, components.space),
    components.fill,
    components.diagnostics,
    components.ruler,
  },
}
