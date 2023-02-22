local components = require('user.plugins.heirline.components')
local utils = require('heirline.utils')

return {
  components.vi_mode,
  components.git.head,
  components.work_dir,
  components.align,
  -- components.noice.mode,
  -- components.noice.search,
  components.file.tabs,
  components.file.format,
  components.file.encoding,
}
