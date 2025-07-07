local components = require('rkernan.heirline.components')
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
    components.space,
    components.git.head,
    components.environment(
      'VIRTUAL_ENV',
      { fg = 'cyan' },
      function (str)
        return string.format(' %s ', vim.fn.fnamemodify(str, ':t'))
      end),
    components.cwd,
    components.space,
    components.search_count,
    components.recording_macro,
    components.fill,
    components.tabsummary,
    components.space,
    components.fileformat,
    components.space,
    components.fileencoding,
  },
}
