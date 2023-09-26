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
    components.vi_mode,
    components.git.head,
    components.work_dir,
    components.align,
    components.file.tabs,
    components.file.format,
    components.file.encoding,
  },
}
