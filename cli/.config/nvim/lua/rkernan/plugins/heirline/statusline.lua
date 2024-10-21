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
    components.shortmode,
    components.space,
    utils.insert(components.gitsigns.head, components.space),
    utils.insert(components.environment('VIRTUAL_ENV', { fg = 'cyan' },
      function (str) return string.format(' %s', vim.fn.fnamemodify(str, ':t')) end),
      components.space),
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
