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
    components.filename,
    components.space,
    components.mini.diff.add,
    components.mini.diff.change,
    components.mini.diff.delete,
    components.fill,
    components.diagnostics.error,
    components.diagnostics.warn,
    components.diagnostics.info,
    components.diagnostics.hint,
    components.ruler,
  },
}
